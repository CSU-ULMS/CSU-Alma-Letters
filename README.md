
This is a collection of the XSL files used to generate letters and slips in
Alma.  In general, we try to
make the files re-usable by others, but we fail in some cases.

## NOTE THAT NOT ALL FILES IN THIS REPOSITORY NEED TO BE CUSTOMIZED
 
 -- As of this writing only a few files have been modified.
 -- XML letters to test customizations can be found on the Ex Libris Developer's site: https://developers.exlibrisgroup.com/blog/Alma-letters-XML-samples-for-working-on-XSL-customization


#Sample XSLT/Letters Customization.
Below is an example of an overdue notice before any customizations.
Figure 1: Pre-Customization Letter.
![Pre-customized letter](/PreCustomized.png)

Figure 2: Post-Customization Letter.
Note: the enlarged font, the changed greeting and the notes on the bottom.
![Post-customized letter](/PostCustomized.png)


## Overview of the .xsl files

Descriptions for the letters can be found in [Ex Libris Knowledge Base](http://knowledge.exlibrisgroup.com/Alma/Product_Documentation/Alma_Online_Help_%28English%29/Administration/Configuring_General_Alma_Functions/Configuring_Alma_Letters#Letter_Types).

Documentation for the fields is not available, and probably isn't something we
can expect anytime soon. Tamar Fuches wrote the following about it [on the Dev
forum](https://developers.exlibrisgroup.com/discussions#!/forum/posts/list/273.page):
"Regarding documentation, we do not have it currently. It will take time to get
this ready."

A curiosity of the letters is that typos are not uncommon; from the name
`FulReasourceRequestSlipLetter` to field names like `autho_initials` and what
have we, odd translation placeholders like `@@You_were_specify@@`. Anyways,
this doesn't affect the end result, it's just kinda annoying to work with,
and makes you wonder if the application code is written using the same amount
of carelessness. Hopefully not.

### Letters Customizations

The XLST/Letters task force determined that only letters sent to patrons would be customized at
implementation.  

### Letters usage

Some letters are used much more than others, and should be prioritized. A sample
of 3080 letters taken during a few days in June 2016 showed the following distribution:

    FulReasourceRequestSlipLetter : 1002
    FulTransitSlipLetter : 834
    FulPlaceOnHoldShelfLetter : 501
    ResourceSharingShippingSlipLetter : 215
    OrderListLetter : 99
    FulIncomingSlipLetter : 96
    FulPersonalDeliveryLetter : 87
    FulUserBorrowingActivityLetter : 75
    AnalyticsLetter : 64
    ConversationLetter : 32
    FulOutgoingEmailLetter : 32
    FulLostRefundFeeLoanLetter : 16
    PurchaseRequestStatusLetter : 7
    FineFeePaymentReceiptLetter : 6
    FulLoanReceiptLetter : 5
    FulReturnReceiptLetter : 3
    FulCancelEmailLetter : 2
    GeneralAssignToLetter : 1
    ProcessBibExportFinishedLetter : 1
    InterestedInLetter : 1
    POLineCancellationLetter : 1

In total, only 21 letters were used, but this was in the summer when we're not sending
overdue letters and such, so I should probably make a new sample later.

### Templates

The files in `xsl/letters/call_template` contains templates used by the other
files. This means that if you intend to use some of our letter files, such as
`xsl/letters/FulReasourceRequestSlipLetter.xsl`, you also need to copy the
template files (or at least some of them).

Ideally, we would have created new template files to hold any new templates
we add, but since we aren't allowed to create new files, we have had to add
new templates to the existing files. Wherever a template is used, however,
we try to remember to add a comment indicating which template file the template
is defined in, to ease lookup.

Our current guideline is to use

* `mailReason.xsl` for all new templates, except templates having
  dependencies on other files (like `style.xsl`). This ensures that
  `mailReason.xsl` can be included in all files (also the sms templates)
  without having to ensure other files are also included. The templates in
  this file are templates we expect can be useful to others as well.

* `header.xsl` for the rest.

Quick overview of new templates we've added:

* `mailReason.xsl`: contains most templates, but not any that depends on other files (such as `style.xsl`).
  * `isoDate` : converts a date from `dd/mm/yyyy` to `YYYY-MM-DD` and strips away time, if present.
  * `stdDate` : converts a date from `dd/mm/yyyy` to `d. m Y` and strips away time, if present. Uses `monthName`
    to produce month names in the user's locale.
  * `pickupNumber` : Template for generating the pickup number.
  * `pickupNumberWithLabel` : More verbose version of the pickup number template.

* `header.xsl`: contains email design templates and templates with dependencies.
  * `head` : Organization logo, letter name (heading) and right-aligned date
  * `headWithoutLogo` : Letter name (heading) and right-aligned date
  * `logo` : Just the logo
  * `emailLogo` : Logo styled for email
  * `email-template` : The main email template

In the other template files we've only done smaller modifications to the
existing templates.



## Tips

* Documentation: https://knowledge.exlibrisgroup.com/Alma/Product_Documentation/Alma_Online_Help_%28English%29/Administration/Configuring_General_Alma_Functions/Configuring_Alma_Letters

* Footer: The link targets for "Contact us" and "My account" are set as
  `email_my_account` and `email_contact_us` in the General Customer Parameters
  mapping table (Administration > General Configuration > Configuration Menu >
  Other Settings). Despite the naming, these can be http URLs.

* For Sublime Text users: Sublime Text does not highlight .xsl files by
  default. Click the current syntax type in the lower right corner of the
  window. This will open the syntax selection menu with the option to Open all
  with current extension as... at the top of the menu. Select XML.

* CSS support in e-mail clients varies alot! [This
  table](https://www.campaignmonitor.com/css/) is therefore super useful!

* `xsl:function` is *not* supported!

* XSLT processing will fail if a file has a `<xsl:call-template>` statement
  that refers to a non-existing template (or a template in a file you haven't
  included). This is even the case if the `<xsl:call-template>` statement is
  in a piece of code that is not used, such as in a template that is never
  called. It took me some time to realize this, because `xsltproc` from the
  command line doesn't fail in that case.

* Testing sms messages: From the "XML To Letter Admin" feature in Alma, you
  only receive one XML file for letters that are sent both on SMS and email.
  If you upload this XML file to the "Notification Template" form, you get the
  email version of the letter. A trick to test the SMS version the letter is
  to just alter the content of `<letter_type>`, for instance from
  `FulPlaceOnHoldShelfLetter` to `SmsFulPlaceOnHoldShelfLetter`, and voila,
  you can upload the letter and preview the SMS (with the first line
  containing the receiver and sender).

* Using `xsltproc` from the command line can be helpful for quick testing,
  albeit without translation string expansions. Example: if you have a file
  `PlaceOnHoldShelfLetter.xml` you've received from "XML To Letter Admin",
  calling `xsltproc --path xsl/letters/call_template
  xsl/letters/sms/SmsFulPlaceOnHoldShelfLetter.xsl PlaceOnHoldShelfLetter.xml`
  will produce:

  ```
  <?xml version="1.0"?>
  12345678 : UiO Realfagsbiblioteket.
  @@can_picked_at@@ UiO Realfagsbiblioteket.
  Hentes i skranken.

   The science of cheese. Av: Tunick, Michael H...

  @@note_item_held_until@@: 15. juli 2016.
  ```

  (Please ignore the xml header..)
