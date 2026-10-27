# סידור מסך הבית של iPhone באמצעות Codex

**חובה: Computer Use.** לביצוע בפועל נדרשת סביבת Codex שכבר מורשית לצפות בחלון iPhone Mirroring על ה-Mac ולשלוט בו, כולל גרירה. ה-Skill אינו מעניק יכולת זו, והתקנת Codex CLI רגילה לבדה אינה מספיקה. בלי Computer Use מתאים — תכנון בלבד.

## מה יש כאן?

Skill נייד בשם `iphone-home-organizer`, שמנחה את Codex לבנות סידור אישי למסך הבית, להציג מראש את השינויים, ורק אחרי אישור מפורש לבצע אותם דרך **iPhone Mirroring של Apple** ב-Mac — אם כבר קיימים בסביבת Codex כלי שליטה מתאימים במחשב.

**זו טיוטת אב־טיפוס, לא מוצר שנבדק על מכשיר.** המשתמש דיווח שביצע תהליך דומה באמצעות האפליקציה של Apple; סביבת ההפעלה המדויקת והגרסאות לא היו זמינות לתיעוד, וה-Mac היה כבוי בעת הכנת החבילה. לכן לא ניתן להבטיח שהחבילה תפעל בכל התקנת Codex. היא אינה מוסיפה כלי שליטה ואינה מבצעת שינוי במכשיר מעצם פתיחתה. המתקין המצורף מעתיק את קובץ הוראות ה-Skill בלבד.

## מתחילים

1. מחלצים את ה-ZIP. תיקיית ה-Skill היא `skills/iphone-home-organizer`, ובה `SKILL.md`; קובץ ההסבר הזה אינו חלק מתיקיית ה-Skill.
2. קוראים את קובץ `install.sh` ובודקים את המקור. אפשר להתקין את הוראות ה-Skill בלבד באמצעות `sh install.sh` משורש החבילה. המתקין מעתיק את קובץ ה-Skill כברירת מחדל אל `$HOME/.agents/skills/iphone-home-organizer/`. אם המשתנה `CODEX_HOME` מוגדר, היעד הוא `$CODEX_HOME/skills/iphone-home-organizer/`. המתקין מסרב לדרוס יעד קיים. הוא אינו מתקין Computer Use, אינו משנה הרשאות ואינו נוגע ב-iPhone. אם הסביבה משתמשת במנגנון אחר לגילוי Skills, משתמשים במנגנון הנתמך שלה או מבקשים מ-Codex לקרוא את הקובץ ישירות.
3. ב-Mac פותחים את iPhone Mirroring, ומשלימים בעצמכם את ההתחברות והאימות. לא מוסרים ל-Codex סיסמה, קוד מכשיר או קוד אימות. בודקים שה-iPhone הנכון מוצג.
4. נותנים ל-Codex את הבקשה שלמטה. מתחילים בתכנון; בודקים היטב את רשימת השינויים לפני אישור ביצוע.

### בקשה להעתקה — עברית

> קרא את ה-Skill המצורף `skills/iphone-home-organizer/SKILL.md` ועזור לי לסדר את מסך הבית של ה-iPhone דרך iPhone Mirroring של Apple ב-Mac. קודם בדוק שזמינים אצלך כלי Computer Use מתאימים לצפייה ולשליטה בחלון האפליקציה, ושאל בקצרה על האפליקציות החשובות, ה-Dock, הווידג׳טים והתיקיות שאני רוצה. שמור כברירת מחדל על ה-Dock ועל הווידג׳טים. הצג סידור מוצע ורשימת שינויים מדויקת; אל תזיז דבר עד שאאשר אותה במפורש. אם אי אפשר לשלוט במכשיר בסביבה הזאת, הכן תכנון והוראות ידניות בלבד.

### Copyable request — English

> Read the attached `skills/iphone-home-organizer/SKILL.md` and help me organize my iPhone Home Screen through Apple's iPhone Mirroring on my Mac. First check which Computer Use tools you actually have for observing and controlling the native application window, then ask briefly about my priority apps, Dock, widgets, and folder preferences. Preserve the Dock and widgets by default. Show a proposed layout and exact change list; do not move anything until I explicitly approve it. If this environment cannot control the device, provide a plan and manual steps only.

אם ה-Skill כבר מותקן ומזוהה בסביבה, אפשר לבקש: `Use $iphone-home-organizer to plan my iPhone Home Screen. Do not apply changes before my explicit approval.`

## פקודת התקנה מהירה

המאגר: [IamShaharFar/iphone-home-organizer](https://github.com/IamShaharFar/iphone-home-organizer). יש לבדוק את המאגר ואת `install.sh` לפני הרצה.

```sh
git clone https://github.com/IamShaharFar/iphone-home-organizer.git && sh iphone-home-organizer/install.sh
```

הפקודה מורידה מאגר Git ואז מפעילה את המתקין המקומי; היא אינה `curl | sh` ואינה מבצעת סידור אוטומטי במכשיר. התחלת שימוש ב-Skill אינה אישור להזזת אפליקציות.

## דרישות וגבולות

לפי [התיעוד של Apple](https://support.apple.com/en-us/120421), נדרשים בין היתר Mac עם Apple silicon או T2 ו-macOS 15 ומעלה, iPhone עם iOS 18 ומעלה וקוד נעילה, אותו Apple Account עם אימות דו־שלבי, Bluetooth ו-Wi-Fi פעילים ו-iPhone נעול בקרבת ה-Mac. יש מגבלות נוספות, כולל זמינות אזורית, ולכן יש לבדוק את התיעוד העדכני.

נדרשת בנפרד סביבת Codex שכבר יכולה לצפות בחלון האפליקציה ולבצע בו פעולות עכבר/גרירה נתמכות. התקנת Codex CLI לבדה אינה מוכיחה שקיימת יכולת כזאת. בלי מכשיר זמין או שליטה מתאימה, עובדים במצב תכנון בלבד.

ה-Skill מסדר מיקומי אפליקציות, תיקיות ווידג׳טים קיימים במסגרת התוכנית המאושרת. הוא אינו מוחק אפליקציות, אינו משנה נתוני אפליקציות, Focus, מסך נעילה או חשבונות, ואינו משנה את הקטגוריות האוטומטיות של App Library. צילום מסך הוא תיעוד חזותי — לא גיבוי שניתן לשחזר ממנו אוטומטית, ואין הבטחה לשחזור מלא.

## שיתוף

אפשר לשתף את החבילה הגנרית הזו. היא אינה כוללת רשימת אפליקציות אישית, צילומי מסך או פרטי חשבון. אין לצרף לשיתוף ציבורי תיעוד אישי מהפעלת ה-Skill.

נוסח קצר שאפשר להתאים לפני פרסום:

> סידרתי את מסך הבית של ה-iPhone בעזרת Codex דרך iPhone Mirroring של Apple על ה-Mac. הכנתי טיוטת Skill לשיתוף: כמה שאלות על ההעדפות, מיפוי מסך הבית, הצעת סידור ואישור לפני הזזות. זו לא התקנה שמעניקה לכל Codex שליטה במחשב — צריך סביבה שכבר תומכת בכך. החבילה החדשה עדיין לא נבדקה על מכשיר; כשאין שליטה זמינה, היא נותנת תכנון והוראות ידניות בלבד.

## בדיקות החבילה

תאריך הכנה: 27 באוקטובר 2026. קובץ ה-Skill עבר את `quick_validate.py` המצורף לכלי יצירת ה-Skills של Codex: בדיקת מבנה YAML, שם, תיאור והיעדר מצייני טיוטה בלתי גמורים. נבדקו גם תחביר המתקין, התקנה בתיקיות זמניות, נתיבים עם רווחים וסירוב לדריסה, וכן תקינות ה-ZIP. בדיקות אלה אינן בדיקת שליטה ב-Mac, גרירה ב-iPhone Mirroring או תאימות לגרסת מכשיר מסוימת. לא בוצעו התקנה לסביבה האמיתית או שינוי במכשיר במהלך ההכנה והבדיקות.

רישיון: [MIT](../LICENSE), לפי בחירת בעל המאגר.
