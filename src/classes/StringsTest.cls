@isTest
private class StringsTest {
    static testMethod void myUnitTest() {
        String encryptString = Strings.encryptString('password');
        String decryptString = Strings.decryptString(encryptString);
        System.assertEquals('password', decryptString);
        
        System.assertEquals(true, Strings.isNullOrEmpty(null));
        System.assertEquals(true, Strings.isNullOrEmpty(''));
        System.assertEquals(false, Strings.isNullOrEmpty('ABC'));
        System.assertEquals(true, Strings.isNullOrEmpty(null, true));
        System.assertEquals(true, Strings.isNullOrEmpty(null, false));
        System.assertEquals(true, Strings.isNullOrEmpty(' ', true));
        System.assertEquals(false, Strings.isNullOrEmpty(' ', false));
        System.assertEquals(false, Strings.isNullOrEmpty('ABC', true));
        System.assertEquals(false, Strings.isNullOrEmpty('ABC', false));
        
        System.assertEquals(false, Strings.isPostalCode(null));
        System.assertEquals(false, Strings.isPostalCode('ABC'));
        System.assertEquals(false, Strings.isPostalCode('100-'));
        System.assertEquals(true, Strings.isPostalCode('100'));
        System.assertEquals(true, Strings.isPostalCode('100-00'));
        System.assertEquals(true, Strings.isPostalCode('100-0001'));
        System.assertEquals(true, Strings.isPostalCode('10000'));
        System.assertEquals(true, Strings.isPostalCode('1000000'));

        System.assertEquals(false, Strings.isPhoneNumber(null));
        System.assertEquals(false, Strings.isPhoneNumber('090'));
        System.assertEquals(false, Strings.isPhoneNumber('090-0000'));
        System.assertEquals(true, Strings.isPhoneNumber('090-0000-0001'));
        System.assertEquals(true, Strings.isPhoneNumber('03-0001-0001'));
        System.assertEquals(true, Strings.isPhoneNumber('0120-000-001'));
        System.assertEquals(true, Strings.isPhoneNumber('09000000001'));
        System.assertEquals(true, Strings.isPhoneNumber('0300010001'));
        System.assertEquals(true, Strings.isPhoneNumber('0120000001'));
        
        System.assertEquals(false, Strings.isEMail(null));
        System.assertEquals(false, Strings.isEMail('abc@abc'));
        System.assertEquals(true, Strings.isEMail('abc@abc.com'));
        System.assertEquals(true, Strings.isEMail('abcd.ab@abc.ne.jp'));
        
        System.assertEquals(false, Strings.isUrl(null));
        System.assertEquals(false, Strings.isUrl('http://'));
        System.assertEquals(true, Strings.isUrl('http://www.abc.com'));
        System.assertEquals(true, Strings.isUrl('http://www.abc.com/'));
        System.assertEquals(true, Strings.isUrl('https://www.abc.com/index.html'));
        System.assertEquals(true, Strings.isUrl('https://www.abc.com/index.html?email=aaa@abc.com'));

        System.assertEquals(false, Strings.isWideKana(null));
        System.assertEquals(false, Strings.isWideKana(''));
        System.assertEquals(false, Strings.isWideKana('あいうえお'));
        System.assertEquals(false, Strings.isWideKana('ｱｲｳｴｵｰ'));
        System.assertEquals(true, Strings.isWideKana('アイウエオー'));


        System.assertEquals(false, Strings.isWideAlphaNumKana(null));
        System.assertEquals(false, Strings.isWideAlphaNumKana(''));
        System.assertEquals(false, Strings.isWideAlphaNumKana('あいうえお'));
        System.assertEquals(false, Strings.isWideAlphaNumKana('ｱｲｳｴｵｰ'));
        System.assertEquals(true, Strings.isWideAlphaNumKana('アイウエオー'));
        System.assertEquals(true, Strings.isWideAlphaNumKana('ＡＢＣＤＥ'));
        System.assertEquals(true, Strings.isWideAlphaNumKana('０１２３４５'));

        System.assertEquals(false, Strings.isDate(null));
        System.assertEquals(false, Strings.isDate(''));
        System.assertEquals(false, Strings.isDate('2011/2/29'));
        System.assertEquals(false, Strings.isDate('2011/13/1'));
        System.assertEquals(true, Strings.isDate('2000/2/29'));
        System.assertEquals(true, Strings.isDate('2004/2/29'));
        System.assertEquals(true, Strings.isDate('2011/05/22'));

        System.assertEquals(false, Strings.isInteger(null));
        System.assertEquals(false, Strings.isInteger(''));
        System.assertEquals(true, Strings.isInteger('1'));
        System.assertEquals(false, Strings.isInteger('1.1'));
        System.assertEquals(false, Strings.isInteger('1,000'));

        System.assertEquals(false, Strings.isDecimal(null));
        System.assertEquals(false, Strings.isDecimal(''));
        System.assertEquals(true, Strings.isDecimal('1'));
        System.assertEquals(true, Strings.isDecimal('1.1'));
        System.assertEquals(true, Strings.isDecimal('1.'));
        System.assertEquals(false, Strings.isDecimal('1,000'));
        System.assertEquals(false, Strings.isDecimal('1,000.1'));

        System.assertEquals('2011-07-14', Strings.createSOQLDate(2011, 7, 14));

        System.assertEquals('', Strings.nullToBlank(null));
        System.assertEquals('TEST', Strings.nullToBlank('TEST'));

        System.assertEquals(false, Strings.isHalfAlphaNum(null));
        System.assertEquals(false, Strings.isHalfAlphaNum(''));
        System.assertEquals(true, Strings.isHalfAlphaNum('az'));
        System.assertEquals(true, Strings.isHalfAlphaNum('AZ'));
        System.assertEquals(true, Strings.isHalfAlphaNum('09'));
        System.assertEquals(true, Strings.isHalfAlphaNum('azAZ09'));
        System.assertEquals(false, Strings.isDecimal('azあ'));
        System.assertEquals(false, Strings.isDecimal('az!'));

        System.assertEquals(false, Strings.isCreditCardNo(null));
        System.assertEquals(false, Strings.isCreditCardNo(''));
        System.assertEquals(true, Strings.isCreditCardNo('375987654321001'));
        System.assertEquals(true, Strings.isCreditCardNo('4000123456789010'));
        System.assertEquals(true, Strings.isCreditCardNo('5419849999999999'));

        System.assertEquals('', Strings.substringB('あい', 1));
        System.assertEquals('あ', Strings.substringB('あい', 2));
        System.assertEquals('あ', Strings.substringB('あい', 3));
        System.assertEquals('あい', Strings.substringB('あい', 4));
        System.assertEquals('ｱ', Strings.substringB('ｱｲ', 1));
        System.assertEquals('ｱｲ', Strings.substringB('ｱｲ', 2));
        System.assertEquals('ｱｲ', Strings.substringB('ｱｲ', 3));
        System.assertEquals('A', Strings.substringB('AB', 1));
        System.assertEquals('AB', Strings.substringB('AB', 2));
        System.assertEquals('あｱ ', Strings.substringB('あｱ ｲ', 4));

//        System.assertEquals(5, Strings.getBytes('あｱ ｲ'));

        System.assertEquals(null, Strings.left(null, 1));
        System.assertEquals('', Strings.left('', 1));
        System.assertEquals('123', Strings.left('12345', 3));
        System.assertEquals('12345', Strings.left('12345', 10));

    }
}