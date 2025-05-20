# ConsentMo CMP Consent State – GTM Variable Template (Unofficial)

A [Google Tag Manager](https://tagmanager.google.com/) variable template to evaluate the user's consent state from **ConsentMo CMP** cookies.

This template allows GTM users to **integrate ConsentMo consent logic into GTM without requiring native integration**. It works by parsing the `cookieconsent_preferences_disabled` cookie and evaluating consent categories for tag firing decisions or Consent Mode setup.

> 🥳 Created by **Jude Nwachukwu Onyejekwe** **[For DumbData](https://www.dumbdata.co/)**

---

## 📦 Features

- Evaluate ConsentMo consent for:
  - All consent categories
  - A specific category
- Supports transforming output values (e.g. `accept`, `deny`, `true`, `false`)
- GTM-native Consent Mode compatibility helper
- Safe fallback behavior when cookie is absent

---

## 🚀 How to Import

1. Download or copy the `template.tpl` file from this repository.
2. In GTM, go to **Templates > Variable Templates**.
3. Click **New**, then the three-dot menu > **Import**.
4. Select the downloaded `template.tpl` file and click **Save**.
5. Now create a new variable using this template.

---

## ⚙️ Variable Configuration

| Field Label                          | Description                                                                 |
|-------------------------------------|-----------------------------------------------------------------------------|
| Consent Check Type                  | Choose between checking all categories or a specific one.                  |
| Consent Category (if specific)      | Select the category to evaluate: Strictly, Analytics, Marketing, Functional |
| Enable Output Transformation        | Toggle transforming the output value into a tag-friendly format.           |
| Granted Output Value                | Select `accept` or `true` when consent is granted.                         |
| Denied Output Value                 | Select `deny` or `false` when consent is denied.                           |
| Treat Undefined as Denied          | When enabled, treats undefined values as "denied".                         |

---

## 📤 Output Format

| Consent Check Type             | Output Type              | Output Example                                          |
|-------------------------------|---------------------------|----------------------------------------------------------|
| All Categories                | Object (per category)     | `{ "Strictly Required Cookies": "granted", "Analytics & Statistics": "denied", ... }` |
| Specific Category             | String                    | `"granted"` or `"denied"` or transformed values          |
| Missing or invalid cookie     | `undefined`               | `undefined`                                              |

---

## 💡 Use Cases

This template is ideal when:

- **ConsentMo CMP is not integrated into GTM**, and you still need to conditionally fire tags.
- You want to **respect user consent preferences** when using third-party tools or advertising platforms.
- You need to **implement Consent Mode behavior manually** based on cookie values.
- You prefer using GTM’s **Custom Template system** for a safer, more maintainable setup.

---

## 🧠 Created By

Made by [Jude for DumbData](https://www.dumbdata.co/), the home of free tools and templates for marketers and analysts.

---

## 📄 License

APACHE License
