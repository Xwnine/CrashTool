# CrashTool

解决各种数组越界、字典空值、字符串下标越界等常见Crash解决，实现App保活。

一些小的自省，自己也是会受到网上所谓的大神的这种那种总结的影响，什么swizzle不安全，try...catch...finaly很耗性能，甚至会造成内存泄漏，然后自己也懒得去翻官方的英文文档。在这里也不讨论这些说法到底对不对，周六重新撸了个，实现也挺简单，放在SafeTool文件夹中，喜欢可以查看源码。半天时间写的比较仓促，这个周会完善单元测试用例，欢迎和我交流，共同进步！


利用runtime特性，通过method swizzle，消息转发实现自动规避Crash的工具。具体代码实现方法有两种，工程中SafeTool文件夹下面的内容中是不用@try...@catch实现的



使用简单，一行代码就可以实现，同时无需改变现有代码，支持cocoapods方式安装。



日常开发中常见的carsh主要发生在下面一些类：

一：NSArray数组

	1. NSArray的快速创建方式 即使用字面量创建的方式，本质其实调用的是2中的方法
	2. +(instancetype)arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt
	3. - (id)objectAtIndex:(NSUInteger)index
	4. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range

二：NSMutableArray数组：

	1. - (id)objectAtIndex:(NSUInteger)index
	2. - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
	3. - (void)removeObjectAtIndex:(NSUInteger)index
	4. - (void)insertObject:(id)anObject atIndex:(NSUInteger)index
	5. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range

三：NSDictionary字典：

	字典的crash主要有下面几个方面：
	a. 中任意key或者value为nil, 会导致crash；
	b. key为空, 造成key value 不匹配, 会crash；
	c. 任意value为nil, 会crash；

	字面量的方式创建的字典，本质也是调用这个方法

	1. +(instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt


四：NSMutableDictionaty字典：

	1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
	2. - (void)removeObjectForKey:(id)aKey


五：NSString字符串：

	1. - (unichar)characterAtIndex:(NSUInteger)index
	2. - (NSString *)substringFromIndex:(NSUInteger)from
	3. - (NSString *)substringToIndex:(NSUInteger)to {
	4. - (NSString *)substringWithRange:(NSRange)range {
	5. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
	6. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
	7. - (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
  
六：NSMutableString字符串：

	1.- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
	2.- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
	3.- (void)deleteCharactersInRange:(NSRange)range;


七：NSAttributeString属性字符串：

	1.- (instancetype)initWithString:(NSString *)str
	2.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr
	3.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs


八：NSMuatableAttributeString属性字符串：

	1.- (instancetype)initWithString:(NSString *)representation;
	2.- (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSString *, id> *)attrs;


九：KVC导致的crash:

	1.- (void)setValue:(id)value forKey:(NSString *)key
	2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
	3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用
	4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
	5.- (void)forwardingTargetForSelector:(SEL)aSelector;

十：解决 unrecognized selector sent to instance 0xxx，利用消息转发机制实现：

	- (id)flee_forwardingTargetForSelector:(SEL)aSelector {

		id proxy = [self flee_forwardingTargetForSelector:aSelector];
		if (!proxy) {           
			NSLog(@"[%@ %@]unrecognized selector crash\n\n%@\n", [self class],      NSStringFromSelector(aSelector), [NSThread callStackSymbols]);        
		   proxy = [[StubProxy alloc] init];
		  }       
		  return proxy; 
	}
	
	

十一：解决Bugly上报的错误：Can't add self as subview：

	这个主要是在push或pop一个视图的时候，并且设置了animated:YES，如果此时动画(animated)还没有完成，这个时候，你在去push或pop另外一个视图的时候，就会造成该异常


使用方式：

	方式1：git clone 整个工程，将CrashTool路径下的所有文件手动拖到你的工程中
	方式2：CocoaPods: 添加 pod 'CrashTool', '~> 1.0' 到你的 Podfile，然后执行pod install 或者pod update

之所以没有将方法交换写在load方法中有几个方面的原因：

	1、swizzle技术影响到整个OS框架，为了规避测试力度不够导致的各类离奇的bug，以及旧代码用到新工程中出现的各种位置的错误
	2、使用可控
	3、应对新的iOS系统发布，系统框架的更新导致一些API发生变化，所交换的方法不存在，导致未知的bug


还未实现的功能：EXC_BAD_ACCESS（野指针）：

	* 出现这个 crash的原因： 访问一个已经释放的对象，或者向一个已经释放的对象发送消息，就会出现这种crash
	* 实现一个类似于Xcode的 NSZombieEnable环境变量机制：用僵尸实现来代替实例的dealloc，在某个实例的引用计数降到0时，该僵尸实现会将该对象转换成僵尸对象。
	* 关于僵尸对象：在启用Xcode的NSZombieEnable的调试机制，runtime系统会将所有已经回收的实例转化成特殊的“僵尸对象”，而不会真正的回收它们。给僵尸对象发送消息后，会抛出异常，并说明异常消息



参考文章：

	http://blog.csdn.net/hypercode/article/details/53434687

	http://devma.cn/blog/2016/11/10/ios-beng-kui-crash-jie-xi/#新老操作系统兼容

	http://stackoverflow.com/questions/19560198/ios-app-error-cant-add-self-as-subview

	http://tech.glowing.com/cn/how-we-made-nsdictionary-nil-safe/

	http://stackoverflow.com/questions/108183/how-to-prevent-sigpipes-or-handle-them-properly



