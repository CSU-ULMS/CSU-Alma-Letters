<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->
        <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

		<br />
		<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->


        <div class="messageArea">
          <div class="messageBody">

			<table cellspacing="0" cellpadding="5" border="0">
              <tr>
              	<td>
					<b>@@message@@</b>
					<br/><br/>
                </td>
              </tr>
              <tr>
              	<td>
					<b>@@loans@@</b>
                </td>
              </tr>

              <tr>
                <td>
                	<table cellpadding="5" class="listing">
						<xsl:attribute name="style">
							<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<tr>
							<th>@@title@@</th>
							<th>@@description@@</th>
							<th>@@author@@</th>
							<th>@@due_date@@</th>
							<th>@@library@@</th>
						</tr>

                		<xsl:for-each select="notification_data/item_loans/item_loan">
						<tr>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="description"/></td>
							<td><xsl:value-of select="author"/></td>
							<td><xsl:value-of select="due_date"/></td>
							<td><xsl:value-of select="library_name"/></td>

						</tr>
						</xsl:for-each>

                	</table>
                </td>
              </tr>
             </table>
				<br />
				<br />
				@@additional_info_1@@
			<br />
			@@additional_info_2@@
				<br />
			<table>
				<tr><td>@@sincerely@@</td></tr>
				<tr><td>@@department@@</td></tr>
			</table>

          </div>
        </div>

<!--IN THIS SECTION YOU CAN ADD INFORMATION ON RENEWING ITEMS -->
<!--- CUSTOMIZE THIS SECTION FOR YOUR OWN INSTITUTION -->
	
<h3>Renewing Items:</h3>
<p>
You may be able to renew your material online at https://libpac.sdsu.edu/patroninfo
</p>

<h3>Returning Items:</h3>
<p>
Directions for returning material can be found at
http://library.sdsu.edu/borrowing/returning-material
</p>

<h3>Questions:</h3>
<p>
Contact the Circulation/Course Reserve department at (619) 594-6793 if you have questions regarding this notice or feel you have received this notice in error.
</p>




        <!-- footer.xsl -->
        <xsl:call-template name="lastFooter" />
         <xsl:call-template name="myAccount" />
		<xsl:call-template name="contactUs" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
