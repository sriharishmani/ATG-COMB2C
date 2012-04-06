<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>

<!-- ATG Training -->
<!-- Creating Commerce Applications Part I -->
<!-- Cart Page -->
<!-- Last modified: 26 Aug 02 by KL -->

<HTML>
  <HEAD>
    <TITLE>Dynamusic Shopping Cart</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Your Shopping Cart"/>
    </dsp:include>
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <jsp:include page="navbar.jsp" flush="true"></jsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" color="midnightblue">

<%-- Chapter 7, Exercise 3, Step 1: Error Handling --%>

<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
   <dsp:param name="exceptions" bean="CartModifierFormHandler.formExceptions"/>
   <dsp:oparam name="outputStart">
      <font color=cc0000><strong><ul>
   </dsp:oparam>
   <dsp:oparam name="outputEnd">
      </ul></strong></font>
   </dsp:oparam>
   <dsp:oparam name="output">
      <li>Error:<dsp:valueof param="message"/><br>
   </dsp:oparam>
</dsp:droplet>

<%-- Chapter 7, Exercise 2 --%>
<%-- Loop through ShippingGroups, then through CommerceItemRelationships to 
display each Commerce Item. Place in form. --%>
<p>
<dsp:form method="post" action="cart.jsp">
  <dsp:droplet name="/atg/dynamo/droplet/ForEach">
    <dsp:param name="array" bean="CartModifierFormHandler.order.ShippingGroups"/>
      
      <dsp:oparam name="output">
      <dsp:param param="element" name="ShippingGroup"/>
    	<dsp:droplet name="/atg/dynamo/droplet/ForEach">
          <dsp:param name="array" param="ShippingGroup.CommerceItemRelationships"/>
	  
      	  <dsp:oparam name="output">
      	  <dsp:param param="element" name="CIRelationship"/>
	    <b>Quantity:</b>
	      <input name='<dsp:valueof param="CIRelationship.Id"/>' value='<dsp:valueof param="CIRelationship.quantity"/>' size="2">&nbsp;
<br> 
            <b>Name:</b> <dsp:valueof param="CIRelationship.commerceItem.auxiliaryData.catalogRef.displayName"/><br>
            <b>Price:</b> <dsp:valueof param="CIRelationship.commerceItem.priceInfo.rawTotalPrice" converter="currency"/><br>
            <b>Amount:</b> <dsp:valueof param="CIRelationship.commerceItem.priceInfo.amount" converter="currency"/><br><br>

      	  </dsp:oparam>
      	  <dsp:oparam name="empty">
            Cart is Empty!!!!
      	  </dsp:oparam>
    	</dsp:droplet>
      </dsp:oparam>
  </dsp:droplet>

</font><p>
  <hr size="0">
  <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">Shopping Cart Totals:</font><p>
  <font face="Verdana,Geneva,Arial" color="midnightblue">

<%-- Chapter 7, Exercise 4: Display Order Total and Recalculate Button --%>
<!-- Order Subtotal and Total -->
  <b>Subtotal:</b> <dsp:valueof bean="ShoppingCart.current.priceInfo.amount" converter="currency">no price</dsp:valueof><br>
  <b>Shipping:</b> <dsp:valueof bean="ShoppingCart.current.priceInfo.shipping" converter="currency">no shipping</dsp:valueof><br>
  <b>Total:</b> <dsp:valueof bean="ShoppingCart.current.priceInfo.total" converter="currency">no total</dsp:valueof>

<!-- Recalculate Button -->
<p>
  <dsp:input type="submit" bean="CartModifierFormHandler.setOrderByRelationshipId" value="Recalculate"/>

<%-- Chapter 7, Exercise 3, Step 2: Add Checkout Button --%>
  <dsp:input type="submit" bean="CartModifierFormHandler.moveToPurchaseInfoByRelId" value="Checkout"/>
  <dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoByRelIdSuccessURL" value="purchaseinfo.jsp"/>
  
</dsp:form>
<p>
<%-- Chapter 7, Optional Exercise 7: Display User's Promotions --%>
<b>Your current Promotions are:</b>
<p>

<dsp:droplet name="/atg/dynamo/droplet/ForEach">
  <dsp:param bean="Profile.activePromotions" name="array"/>
  <dsp:oparam name="output">
    <li><dsp:valueof param="element.promotion.displayName"/>
  </dsp:oparam>
  <dsp:oparam name="empty">
    You do not have any Promotions!
  </dsp:oparam>
</dsp:droplet>
</font>
</td></tr>
</table>
</body>
</html>


</dsp:page>
