# סידור מסך הבית של iPhone — Skill למגוון אייגנטים

**חובה: Computer Use.** לביצוע בפועל נדרש אייגנט שכבר מורשה לצפות בחלון iPhone Mirroring על ה-Mac ולשלוט בו, כולל גרירה. התקנת ה-Skill אינה מוסיפה כלי שליטה או הרשאות. בלי גישה מתאימה למחשב ול-iPhone — תכנון והוראות ידניות בלבד.

ה-Skill כתוב בפורמט Agent Skills ללא תלות בכלי של ספק מסוים. הוא שואל על ההעדפות, ממפה את מסך הבית, מציג תוכנית מדויקת וממתין לאישור מפורש לפני הזזות. ה-Dock והווידג׳טים נשמרים כברירת מחדל.

**אב־טיפוס שלא נבדק על מכשיר.** תהליך דומה דווח כמוצלח עם Codex ו-iPhone Mirroring; החבילה הזו נכתבה בלי גישה לאותו Mac או להגדרותיו. התאמה לפורמט ולנתיב התקנה אינה הוכחה שהאייגנט יכול לשלוט במחשב. [מטריצת התאימות והמקורות](../README.md#compatibility-instructions-are-not-device-control).

התמונה במאגר היא איור קונספט שנוצר ב-AI — לא צילום מסך ולא ראיה לביצוע על מכשיר. האזכור של Codex באיור משקף את התהליך המקורי, לא מגבלה של הוראות ה-Skill.

## התקנה מהירה

יש לבדוק את [המאגר](https://github.com/IamShaharFar/iphone-home-organizer) ואת `install.sh` לפני הרצה.

התקנה לנתיב המשותף, המתועד עבור Codex, Cursor, Gemini CLI ו-OpenCode:

```sh
git clone https://github.com/IamShaharFar/iphone-home-organizer.git && sh iphone-home-organizer/install.sh
```

ל-Claude Code:

```sh
git clone https://github.com/IamShaharFar/iphone-home-organizer.git && sh iphone-home-organizer/install.sh --agent claude
```

אם המאגר כבר הורד, לא משכפלים שוב. מתוך תיקיית המאגר בוחרים יעד אחד:

| בחירה | יעד |
|---|---|
| `sh install.sh` או `--agent shared` | `~/.agents/skills` |
| `--agent codex` | `~/.agents/skills`, או `$CODEX_HOME/skills` אם המשתנה מוגדר |
| `--agent claude` | `~/.claude/skills` |
| `--agent cursor` | `~/.cursor/skills` |
| `--agent gemini` | `~/.gemini/skills` |
| `--agent opencode` | `~/.config/opencode/skills` |

למשל: `sh install.sh --agent cursor`. כל יעד מקבל רק את `iphone-home-organizer/SKILL.md`. המתקין מסרב לדרוס יעד קיים, אינו מתקין אפליקציות, אינו מפעיל הרשאות ואינו נוגע ב-iPhone. אין להתקין עותקים כפולים בכמה נתיבי חיפוש של אותו אייגנט בלי לבדוק את סדר העדיפות.

באייגנטים אחרים, כולל Grok Bot, אין כאן הנחה לגבי נתיב ייבוא או שליטה מקומית ב-Mac. אם הסביבה תומכת בכך, אפשר לבקש ממנה לקרוא ישירות את `skills/iphone-home-organizer/SKILL.md`; זו חלופת הוראות, לא הבטחת יכולת ביצוע.

## מתחילים להשתמש

1. פותחים את iPhone Mirroring ב-Mac ומוודאים שזה ה-iPhone הנכון. משלימים בעצמכם את ההתחברות והאימות. לא מוסרים לאייגנט סיסמה או קוד אימות.
2. בוחרים את ה-Skill באמצעות המנגנון המתועד של האייגנט, או מצרפים את `skills/iphone-home-organizer/SKILL.md` ומבקשים לקרוא אותו. ב-Codex אפשר `$iphone-home-organizer`; ב-Claude Code וב-Cursor אפשר `/iphone-home-organizer`.
3. משתמשים בבקשה הבאה:

> קרא ופעל לפי ה-Skill בשם iphone-home-organizer כדי לעזור לי לסדר את מסך הבית דרך iPhone Mirroring של Apple ב-Mac. קודם בדוק אילו יכולות Computer Use באמת זמינות לך לשליטה במחשב הזה. שאל בקצרה על האפליקציות החשובות ועל העדפות התיקיות שלי. שמור על ה-Dock והווידג׳טים כברירת מחדל. הצג תוכנית ורשימת שינויים מדויקת, ואל תזיז דבר עד שאאשר אותה במפורש. אם אי אפשר לשלוט ב-Mac וב-iPhone המשוקף, הכן רק תכנון והוראות ידניות; אל תטען שהשינויים בוצעו.

## דרישות וגבולות

יש לבדוק את [דרישות Apple והזמינות האזורית](https://support.apple.com/en-us/120421): בין היתר Mac עם Apple silicon או T2 ו-macOS 15 ומעלה, iPhone עם iOS 18 ומעלה וקוד נעילה, אותו Apple Account עם אימות דו־שלבי, Bluetooth ו-Wi-Fi פעילים ו-iPhone נעול בקרבת ה-Mac.

ה-Skill אינו מוחק אפליקציות, משנה נתוני אפליקציות, Focus, מסך נעילה, חשבונות או אימות; ואינו עורך קטגוריות אוטומטיות של App Library. הוא עוצר כשגרירה אינה ודאית. צילום מסך הוא תיעוד, לא גיבוי לשחזור אוטומטי; אין הבטחה לשחזור מלא.

אפשר לשתף את החבילה הגנרית. אין לצרף אליה צילומי מכשיר, רשימות אפליקציות אישיות או פרטי חשבון.

## בדיקות ורישיון

31 בדיקות מתקין מבודדות ותקינות מבנה ה-Skill עברו בהצלחה. הבדיקות רצו על Linux ובתיקיות זמניות בלבד; לא בוצעו בדיקת macOS, ייבוא בפועל לכל אייגנט או בדיקת שליטה במכשיר. לא בוצעו התקנה בסביבה האמיתית או שינוי במכשיר.

רישיון: [MIT](../LICENSE). הוכן ב-27 באוקטובר 2026.
