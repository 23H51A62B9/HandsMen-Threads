@IsTest
private class OrderTriggerHandlerTest {

    @IsTest
    static void testValidConfirmedOrder() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Confirmed',
            Quantity__c = 501
        );

        Test.startTest();
        OrderTriggerHandler.validateOrderQuantity(new List<HandsMen_Order__c>{ order });
        Test.stopTest();

        System.assertEquals(false, order.hasErrors(), 'Confirmed order with quantity > 500 should be valid.');
    }

    @IsTest
    static void testInvalidConfirmedOrder() {
        HandsMen_Order__c lowQtyOrder = new HandsMen_Order__c(
            Status__c = 'Confirmed',
            Quantity__c = 500
        );
        HandsMen_Order__c nullQtyOrder = new HandsMen_Order__c(
            Status__c = 'Confirmed',
            Quantity__c = null
        );

        Test.startTest();
        OrderTriggerHandler.validateOrderQuantity(new List<HandsMen_Order__c>{ lowQtyOrder, nullQtyOrder });
        Test.stopTest();

        System.assertEquals(true, lowQtyOrder.hasErrors(), 'Confirmed order with quantity <= 500 should fail.');
        System.assertEquals('For Status "Confirmed", Quantity must be more than 500.', lowQtyOrder.getErrors()[0].getMessage());
        System.assertEquals(true, nullQtyOrder.hasErrors(), 'Confirmed order with null quantity should fail.');
    }

    @IsTest
    static void testValidPendingOrder() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Pending',
            Quantity__c = 201
        );

        Test.startTest();
        OrderTriggerHandler.validateOrderQuantity(new List<HandsMen_Order__c>{ order });
        Test.stopTest();

        System.assertEquals(false, order.hasErrors(), 'Pending order with quantity > 200 should be valid.');
    }

    @IsTest
    static void testInvalidPendingOrder() {
        HandsMen_Order__c lowQtyOrder = new HandsMen_Order__c(
            Status__c = 'Pending',
            Quantity__c = 200
        );
        HandsMen_Order__c nullQtyOrder = new HandsMen_Order__c(
            Status__c = 'Pending',
            Quantity__c = null
        );

        Test.startTest();
        OrderTriggerHandler.validateOrderQuantity(new List<HandsMen_Order__c>{ lowQtyOrder, nullQtyOrder });
        Test.stopTest();

        System.assertEquals(true, lowQtyOrder.hasErrors(), 'Pending order with quantity <= 200 should fail.');
        System.assertEquals('For Status "Pending", Quantity must be more than 200.', lowQtyOrder.getErrors()[0].getMessage());
        System.assertEquals(true, nullQtyOrder.hasErrors(), 'Pending order with null quantity should fail.');
    }

    @IsTest
    static void testValidRejectionOrder() {
        HandsMen_Order__c order = new HandsMen_Order__c(
            Status__c = 'Rejection',
            Quantity__c = 0
        );

        Test.startTest();
        OrderTriggerHandler.validateOrderQuantity(new List<HandsMen_Order__c>{ order });
        Test.stopTest();

        System.assertEquals(false, order.hasErrors(), 'Rejection order with quantity == 0 should be valid.');
    }

    @IsTest
    static void testInvalidRejectionOrder() {
        HandsMen_Order__c nonZeroQtyOrder = new HandsMen_Order__c(
            Status__c = 'Rejection',
            Quantity__c = 10
        );
        HandsMen_Order__c nullQtyOrder = new HandsMen_Order__c(
            Status__c = 'Rejection',
            Quantity__c = null
        );

        Test.startTest();
        OrderTriggerHandler.validateOrderQuantity(new List<HandsMen_Order__c>{ nonZeroQtyOrder, nullQtyOrder });
        Test.stopTest();

        System.assertEquals(true, nonZeroQtyOrder.hasErrors(), 'Rejection order with quantity != 0 should fail.');
        System.assertEquals('For Status "Rejection", Quantity must be 0.', nonZeroQtyOrder.getErrors()[0].getMessage());
        System.assertEquals(true, nullQtyOrder.hasErrors(), 'Rejection order with null quantity should fail.');
    }
}
