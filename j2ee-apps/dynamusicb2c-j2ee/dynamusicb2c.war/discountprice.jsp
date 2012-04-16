<%@ taglib uri="/dspTaglib" prefix="dsp"%>
<dsp:page>

	<!-- ATG Training -->
	<!-- Creating Commerce Applications -->
	<!-- Fragment for displaying a SKU's discounted price -->
	<!-- Last modified: 4 Apr 06 by KL -->

	<!-- Title: Discount Price Page -->

	<%-- Chapter 5, Exercise 1 --%>

	<dsp:droplet name="/atg/commerce/pricing/PriceItem">
		<dsp:param name="item" param="sku" />
		<dsp:param name="product" param="product" />
		<dsp:oparam name="output">
        Last price:
		<dsp:droplet name="/atg/dynamo/droplet/Switch">
				<dsp:param name="value" param="sku.onSale" />
				<dsp:oparam name="true">
					<dsp:valueof converter="currency" param="element.priceInfo.salePrice"/>
				</dsp:oparam>
                <dsp:oparam name="false">
                    <dsp:valueof converter="currency" param="element.priceInfo.listPrice"/>
                </dsp:oparam>
			</dsp:droplet>
        Your price:
            <dsp:valueof converter="currency" param="element.priceInfo.amount"/>
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>

