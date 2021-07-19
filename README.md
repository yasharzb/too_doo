# too_doo
<div dir="rtl">

## اسامی
یاشار ظروفچی(۹۷۱۰۶۱۱۹)، رضا عبداله زاده(۹۷۱۰۶۱۳۲)، امین مقراضی(۹۷۱۰۶۲۷۳)

نکات
====

- این پروژه ابتدا روی چند فایل بود و سپس به علت عدم امکان راه‌اندازی ماشین مجازی مک توسط دیگر همگروهان، همه‌ی کد به فایل `main.swift` منتقل شد. 
- کامیتی که مربوط به دوشنبه ۲۸ تیر ماه است تنها حذف فایل‌های اضافی و تغییر مکان یک تابع (به علت محل تعریف آن) است و تغییری در منطق کد ایجاد نشده است.
- همچنین علت اینکه آخرین کامیت (پیش از ۲۸ تیر) حدود یک هفته پس از ددلاین است، ابتلای یکی از دوستان به کرونا بود (که با خود استاد هماهنگ شد). همانطور که مشخص است کامیت‌های باقی اعضای گروه پیش از موعد مقرر تمرین است.

توضیح کد
========

فرمت دستورات با زدن کامند help قابل رویت است درنتیجه نیازی به توضیح آن در این مستند وجود ندارد. صرفا امضای توابع و ساختار کلاس‌ها شرح داده می‌شوند.

### کلاس‌ها

<div dir="ltr">

```swift
class TodoItem : Hashable, CustomStringConvertible {
    let id :Int
    var title = "untitled"
    var category :String? = nil
    var content = "-"
    var priority :Int = -1
    var time: Date
}
```
</div>

کلاس مربوط به یک مورد to-do. در آن `id` به صورت ترتیبی، زمان از سیستم و باقی از سمت کاربر تعیین می‌شود.

### اینام‌ها

<div dir="ltr">

```swift
enum EntityType: String {
    case    ITEM
    case    TITLE
    case    CONTENT
    case    PRIORITY
    case    TIME
    case    CATEGORY
}
```
</div>

نوع ماهیت، می‌تواند مورد to-do، دسته‌بندی یا اجزای مختلفشان باشد. در توابعی مانند ایجاد، مرتب‌سازی و ویرایش، این گونه‌بندی حائز اهمیت است.

<div dir="ltr">

```swift
enum Command: String, CaseIterable {
    case    CREATE
    case    VIEW_ALL
    case    VIEW
    case    EDIT
    case    DELETE
    case    SORT
    case    ADD
    case    HELP
    case    CLEAR
    case    EXIT
}
```
</div>

نوع دستور ورودی کاربر

<div dir="ltr">

```swift
enum ParamOrder: Int {
    case    CMD = 0
    case    PARAM_1
    case    PARAM_2
    case    PARAM_3
    case    PARAM_4
}
```
</div>

ترتیب پارامترهای یک دستور ورودی کاربر پس از tokenize کردن

<div dir="ltr">

```swift
enum EDIT_TYPE: String, CaseIterable{
    case TITLE
    case CONTENT
    case PRIORITY
}
```
</div>

موردی که کاربر متمایل به ویرایش آن است که می‌تواند عنوان، محتوا و یا اولویت وظیفه‌ باشد.

<div dir="ltr">

```swift
enum SORT_TYPE: String, CaseIterable {
    case    TITLE
    case    PRIORITY
    case    TIME
}
```
</div>

تعیین می‌کنند که چه طور مرتب سازی‌ای مد نظر است. نوع آن از کاربر گرفته می‌شود

### توابع

به صورت کلی، هر دستوری ابتدا وارد تابع `handle_cmd` می‌شود و سپس پس از تعیین نوع دستور وارد تابع `handleFunction` می‌شود که `Function` یکی از موارد زیر است

- مشاهده‌ی راهنما
    
    مشاهده‌ی راهنمای یک تک دستور

    <div dir="ltr">

    ```swift
    func help(command: Command?) -> String
    ```
    </div>
- ساخت یک مورد to-do
    
    از context با کلمات جدا از هم نیز پشتیبانی می‌کند.

    <div dir="ltr">

    ```swift
    func createItem(inpTitle: String?, inpContent: String?, inpPriority: Int?, command: Command)
    ```
    </div>
- ساخت یک دسته‌بندی
    
    <div dir="ltr">

    ```swift
    func createCategory(inpCategoryName: String?, command: Command)
    ```
    </div>
- مشاهده‌ی همه‌ی todo itemها 
    
    <div dir="ltr">

    ```swift
    func viewAllItems()
    ```
    </div>
- مشاهده‌ی یک todo item خاص با استفاده از آیدی آن
    
    <div dir="ltr">

    ```swift
    func viewItem(inpId: Int?, command: Command)
    ```
    </div>
- مشاهده‌ی همه‌ی دسته‌بندی‌ها 

    <div dir="ltr">

    ```swift
    func viewAllCategories()
    ```
    </div>
- مشاهده‌ی یک دسته‌بندی با استفاده از نام آن
    
    <div dir="ltr">

    ```swift
    func viewCategory(inpCategoryName: String?, command: Command)
    ```
    </div>
- ویرایش یک todo item
    
    <div dir="ltr">

    ```swift
    func editItem(inpId: Int?, inpTitle: String?=nil, inpContent: String?=nil, inpPriority: Int?=nil, command: Command)
    ```
    </div>
- حذف یک todo item
    
    <div dir="ltr">

    ```swift
    func deleteItem(inpId: Int?, command: Command)
    ```
    </div>
- نمای مرتب شده
    
    <div dir="ltr">

    ```swift
    func viewSorted(inpSortType: SORT_TYPE?, asc: Bool=true, command: Command)
    ```
    </div>
- اضافه شدن یک todo item به دسته‌بندی
    
    <div dir="ltr">

    ```swift
    func addToCategory(inpItemId: Int?, inpCategoryName: String?, command: Command)
    ```
    </div>

### خطاها

خطاها نیز عبارت اند از:
- خطای ناموجود بودن دستور: که به طور موردی توسط دستور print چاپ شده است.
- خطای پارامترهای اشتباه در یک دستور: این خطا توسط تابع InvalidCommand اطلاع داده می‌شود.
- خطاهای ناموجود بودن todo item
در دستورات حذف، تغییر و نمایش todo item ها و همینطور افزودنشان به یک دسته رخ می‌دهد و با دستور print اطلاع داده می‌شود.
- خطای نبود دسته‌بندی وارد شده و یا تکراری بودن دسته‌بندی وارد شده که مورد اول در دستورات اضافه کردن todo item به یک دسته بندی و نمایش todo item های یک دسته بندی و مورد دوم در ساخت یک دسته‌بندی جدید رخ می‌دهد. 
- خطای نادرست بودن کلیدواژه های دستورات view و sort که با دستور print اطلاع داده‌ می‌شود.

نکته‌‌ی دیگر اینکه اگر دستوری از لحاظ ساختاری اشتباه وارد شود و قابل اجرا نباشد شکل صحیح آن از طریق تابع help برای کاربر نمایش داده‌ می‌شود.


### دستورات اضافه
دو دستور exit و clear نیز در لیست دستورات وارد شده است که به ترتیب برنامه را به اتمام می‌رسانند و محیط ترمینال را پاک می‌کنند.
</div>


