# CrashTool

解决各种数组越界、字典空值、字符串下标越界等常见Crash解决，实现App保活。

利用runtime特性，实现常见Crash规避，实现思路很简单，具体请看源码。单元测试较完整，经过一段时间的测试和修改，决定将method exchange的代码放到category的load方法中，使用的时候无需再添加任何代码。






系统要求

	该项目最低支持 iOS 7.0 和 Xcode 7.0， 暂不支持MRC。




安装

CocoaPods

	在 Podfile 中添加 pod 'CrashTool'。
	执行 pod install 或 pod update。

手动安装

	下载 CrashTool 文件夹内的所有内容。
	将 CrashTool 内的源文件添加(拖放)到你的工程，给NSMutableArray+SafeMRC文件添加 -fno-objc-arc标志。
	



简单总结一下，日常开发中常见的carsh主要发生在下面一些类：

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
	.- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
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
		

十：解决Bugly上报的错误：Can't add self as subview：

	这个主要是在push或pop一个视图的时候，并且设置了animated:YES，如果此时动画(animated)还没有完成，这个时候，你在去push或pop另外一个视图的时候，就会造成该异常



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



