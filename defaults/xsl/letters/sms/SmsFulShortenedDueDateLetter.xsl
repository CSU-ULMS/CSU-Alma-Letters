<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
 <xsl:template match="/">

<xsl:value-of select="notification_data/receivers/receiver/user_phone/phone"/> : <xsl:value-of select="notification_data/organization_unit/name"/>.
@@hi@@ <xsl:value-of select="notification_data/user_for_printing/name"/>,
@@title@@ &#160;<xsl:value-of select="notification_data/item_loan/title"/>
@@due_back@@ &#160;<xsl:value-of select="notification_data/item_loan/shortened_due_date_reason"/>.
@@pleaseContact@@.
 </xsl:template>
</xsl:stylesheet>