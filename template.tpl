___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "ConsentMo CMP Consent State",
  "description": "Use with the ConsentMo CMP to identify the individual website user\u0027s consent state and configure when tags should execute.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "consentmoConsentStateCheckType",
    "displayName": "Select Consent State Check Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "consentmoAllConsentState",
        "displayValue": "All Consent State Check"
      },
      {
        "value": "consentmoSpecificConsentState",
        "displayValue": "Specific Consent State"
      }
    ],
    "simpleValueType": true,
    "help": "Select the type of consent state check you want to perform—either a specific consent category or all consent categories."
  },
  {
    "type": "RADIO",
    "name": "consentmoConsentCategoryCheck",
    "displayName": "Select Consent Category",
    "radioItems": [
      {
        "value": "consentmoANALYTICSStat",
        "displayValue": "Analytics \u0026 Statistics"
      },
      {
        "value": "consentmoStrictly",
        "displayValue": "Strictly Required Cookies"
      },
      {
        "value": "consentmoMARKETINGRetarget",
        "displayValue": "Marketing and Retargeting"
      },
      {
        "value": "consentmoFunctional",
        "displayValue": "Functional Cookies"
      }
    ],
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "consentmoConsentStateCheckType",
        "paramValue": "consentmoSpecificConsentState",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "consentmoEnableOptionalConfig",
    "checkboxText": "Enable Optional Output Transformation",
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "consentmoOptionalConfig",
    "displayName": "Consentmo Consent State Value Tranformation",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SELECT",
        "name": "consentmoGranted",
        "displayName": "Transform \"Granted\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "consentmoGrantedAccept",
            "displayValue": "accept"
          },
          {
            "value": "consentmoGrantedtTrue",
            "displayValue": "true"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SELECT",
        "name": "consentmoDenied",
        "displayName": "Transform \"Denied\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "consentmoDeniedDeny",
            "displayValue": "deny"
          },
          {
            "value": "consentmoDeniedFalse",
            "displayValue": "false"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "consentmoUndefined",
        "checkboxText": "Also transform \"undefined\" to \"denied\"",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "consentmoEnableOptionalConfig",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const getCookieValues = require('getCookieValues');
const decode = require('decodeUriComponent');
const getType = require('getType');

const checkType = data.consentmoConsentStateCheckType;
const specificCategory = data.consentmoConsentCategoryCheck;

const enableTransform = data.consentmoEnableOptionalConfig;
const grantedTransform = data.consentmoGranted;
const deniedTransform = data.consentmoDenied;
const transformUndefinedToDenied = data.consentmoUndefined;

// Consent categories and their cookie values
const categoryMap = {
  consentmoStrictly: 'strictly',
  consentmoANALYTICSStat: 'analytics',
  consentmoMARKETINGRetarget: 'marketing',
  consentmoFunctional: 'functionality'
};

// Map internal values to readable keys
const readableCategories = {
  strictly: 'Strictly Required Cookies',
  analytics: 'Analytics & Statistics',
  marketing: 'Marketing and Retargeting',
  functionality: 'Functional Cookies'
};

const cookieName = 'cookieconsent_preferences_disabled';
const cookieValues = getCookieValues(cookieName);
if (getType(cookieValues) !== 'array' || cookieValues.length === 0) return undefined;

const decoded = cookieValues.length ? decode(cookieValues[0]) : '';
const deniedList = decoded ? decoded.split(',') : [];

// Evaluate consent value
function evaluateConsent(categoryKey) {
  if (categoryKey === 'strictly') return 'granted';
  if (deniedList.indexOf(categoryKey) !== -1) return 'denied';
  return 'granted';
}

// Optional transformation
function transform(value) {
  if (!enableTransform) return value;
  if (value === undefined && transformUndefinedToDenied) value = 'denied';

  if (value === 'granted') {
    if (grantedTransform === 'consentmoGrantedAccept') return 'accept';
    if (grantedTransform === 'consentmoGrantedtTrue') return 'true';
  } else if (value === 'denied') {
    if (deniedTransform === 'consentmoDeniedDeny') return 'deny';
    if (deniedTransform === 'consentmoDeniedFalse') return 'false';
  }
  return value;
}

// Check type: All Consent Categories
if (checkType === 'consentmoAllConsentState') {
  const result = {};
  result['Strictly Required Cookies'] = transform(evaluateConsent('strictly'));
  result['Analytics & Statistics'] = transform(evaluateConsent('analytics'));
  result['Marketing and Retargeting'] = transform(evaluateConsent('marketing'));
  result['Functional Cookies'] = transform(evaluateConsent('functionality'));
  return result;
}

// Check type: Specific Consent Category
if (checkType === 'consentmoSpecificConsentState') {
  const categoryKey = categoryMap[specificCategory];
  const value = evaluateConsent(categoryKey);
  return transform(value);
}

// Default fallback
return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "cookieconsent_preferences_disabled"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 5/6/2025, 10:19:21 AM


