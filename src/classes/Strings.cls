global with sharing class Strings {
    /** 暗号化キー */
    private static final String cryptoPrivateKey = 'xcI&.q2u{N,W2#;f_viWQ1D2t\\ULBV>O';
    /** 空文字列の定数 */
    public static final String empty = '';

    /**
      * 文字列を暗号化します。
      * @param cipherText 暗号化対象の文字列
      * @return 暗号化された文字列
      */
    global static String encryptString(String cipherText) {
        Blob encryptedData = Crypto.encryptWithManagedIV('AES256', Blob.valueOf(Strings.cryptoPrivateKey), Blob.valueOf(cipherText));
        return EncodingUtil.base64Encode(encryptedData);
    }

    /**
      * 文字列を複合化します。
      * @param cipherText 複合化対象の文字列
      * @return 複合化された文字列
      */
    global static String decryptString(String cipherText) {
        Blob decryptedData = Crypto.decryptWithManagedIV('AES256', Blob.valueOf(Strings.cryptoPrivateKey), EncodingUtil.base64Decode(cipherText));
        return decryptedData.toString();
    }

    /**
      * 文字列が null または、空文字かを判定します。
      * @param value 判定対象の文字列
      * @param permittedWhiteSpace 空白のみの場合も空文字と見なす場合は true。それ以外は false。
      * @return null または、空文字の場合は true。それ以外は false。
      */
    global static Boolean isNullOrEmpty(String value, Boolean permittedWhiteSpace) {
        if (permittedWhiteSpace && value != null) {
            return Strings.isNullOrEmpty(value.trim());
        } else {
            return Strings.isNullOrEmpty(value);
        }
    }

    /**
      * 文字列が null または、空文字かを判定します。
      * @param value 判定対象の文字列
      * @return null または、空文字の場合は true。それ以外は false。
      */
    global static Boolean isNullOrEmpty(String value) {
        return value == null || value.length() == 0;
    }

    /**
      * 文字列が郵便番号形式かを判定します。
      * @return 郵便番号形式の場合は true。それ以外は false。
      */
    global static Boolean isPostalCode(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '^\\d{3}(?:-?(?:\\d{2}|\\d{4}))?$';
        return Pattern.matches(p, value);
    }

    /**
      * 文字列が電話番号形式かを判定します。
      * @return 電話番号形式の場合は true。それ以外は false。
      */
    global static Boolean isPhoneNumber(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '(?!^(090|080|070))(?=^\\d{2,5}?-\\d{1,4}?-\\d{4}$)[\\d-]{12}|' +
                    '(?=^(090|080|070)-\\d{4}-\\d{4}$)[\\d-]{13}|' + 
                    '(?=^0120-\\d{2,3}-\\d{3,4})[\\d-]{12}|' +
                    '^0800-\\d{3}-\\d{4}';
        if (Pattern.matches(p, value)) {
            return true;
        } else {
            p = '(?!^(090|080|070))^[\\d]{10}|' +
                '(090|080|070)[\\d]{8}';
            return Pattern.matches(p, value);
        }
    }

    /**
      * 文字列が電子メール形式かを判定します。
      * @return 電子メール形式の場合は true。それ以外は false。
      */
    global static Boolean isEMail(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '[\\w\\.\\-]+@(?:[\\w\\-]+\\.)+[\\w\\-]+';
        return Pattern.matches(p, value);
    }

    /**
      * 文字列がURL形式かを判定します。
      * @return URL形式の場合は true。それ以外は false。
      */
    global static Boolean isUrl(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '^(https?|ftp):\\/\\/([^\\x00-\\x20()\"<>\\x7F-\\xFF])+';
        return Pattern.matches(p, value);
    }

    /**
      * 文字列が日付形式かを判定します。
      * @return 日付形式の場合は true。それ以外は false。
      */
    global static Boolean isDate(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '^(?:[0-9]{4}/(?:(?:0?[1-9]|1[0-2])/(?:0?[1-9]|1[0-9]|2[0-8])|' +
                    '(?:0?[13-9]|1[0-2])/(?:29|30)|(?:0?[13578]|1[02])/31)|' +
                    '(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:[02468][048]|[13579][26])00)/0?2/29)$';
        return Pattern.matches(p, value);
    }
    
    /**
      * 文字列が Integer として有効かを判定します。
      * @return 有効な場合は true。それ以外は false。
      */
    global static Boolean isInteger(String value) {
        try {
            Integer.valueOf(value);
            
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
    
    /**
      * 文字列が Decimal として有効かを判定します。
      * @return 有効な場合は true。それ以外は false。
      */
    global static Boolean isDecimal(String value) {
        try {
            Decimal.valueOf(value);
            
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
    
    /**
      * 文字列が全角カナのみかを判定します。
      * @return 全角カナの場合は true。それ以外は false。
      */
    global static Boolean isWideKana(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '^[ァ-ー]+$';
        return Pattern.matches(p, value);
    }

    /**
      * 文字列が全角英数カナのみかを判定します。
      * @return 全角英数カナの場合は true。それ以外は false。
      */
    global static Boolean isWideAlphaNumKana(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '^[０-９ａ-ｚＡ-Ｚァ-ー]+$';
        return Pattern.matches(p, value);
    }

    /**
      * nullの場合に空文字を返します。
      * @return nullの場合 空文字を返す。それ以外はそのまま。
      */
    global static String nullToBlank(String value) {
        if (value == null) {
            value = '';
        }
        return value;
    }

    /**
     * 年、月、日からSOQL用日付文字列「YYYY-MM-DD」を取得します。
     * 
     *  @param  year    年
     *  @param  month   月
     *  @param  day     日
     *  @return         「YYYY-MM-DD」の文字列
     */
    global static String createSOQLDate(Integer year, Integer month, Integer day){
        return Strings.createSOQLDate(Date.newInstance(year, month, day));
    }

    /**
     * 年、月、日からSOQL用日付文字列「YYYY-MM-DD」を取得します。
     * 
     *  @param  dt      日付
     *  @return         「YYYY-MM-DD」の文字列
     */
    global static String createSOQLDate(Date dt){
        return dt.format().replaceAll('/', '-');
    }

    /**
      * 文字列が半角英数のみかを判定します。
      * @return 半角英数の場合は true。それ以外は false。
      */
    global static Boolean isHalfAlphaNum(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '^[0-9a-zA-Z]+$';
        return Pattern.matches(p, value);
    }

    /**
      * 文字列がクレジットカード番号形式かを判定します。
      * VISA, MasterCard, American Express のフォーマットに対応。
      * @return クレジットカード番号形式の場合は true。それ以外は false。
      */
    global static Boolean isCreditCardNo(String value) {
        if (Strings.isNullOrEmpty(value)) return false;

        String p = '^((4\\d{3})|(5[1-5]\\d{2})|(6011))([- ])?\\d{4}([- ])?\\d{4}([- ])?\\d{4}|3[4,7]\\d{13}$';
        return Pattern.matches(p, value);
    }

    /**
      * 文字列を先頭から指定バイト数で取得します。
      * @param  value 取得元の文字列
      * @param  length 取得するバイト数
      * @return 取得した文字列。
      */
    global static String substringB(String value, Integer length) {
        if (Strings.isNullOrEmpty(value)) return null;

        String result = Strings.empty;
        Integer sumLength = 0;
        Pattern matcher = Pattern.compile('^[ -~｡-ﾟ]+$');
        for (Integer i = 0; i < value.length(); i++) {
            // 1文字取得
            String c = value.substring(i, i + 1);
            
            if (matcher.matcher(c).matches()) {
                // 半角
                sumLength = sumLength + 1;
            } else {
                // 全角
                sumLength = sumLength + 2;
            }

            if (sumLength <= length) {
                // 指定バイト数内
                result = result + c;
            } else {
                // 指定バイト数を超えた場合
                break;
            }
        }
        
        return result;
    }
    
    /**
     * 文字列のバイト数を取得します。
     *
     * @param value 取得対象の文字列。
     * @return バイト数。
     */
    private static Integer getBytes(String value) {
        return Blob.valueOf(value).size();
    }

    /**
     * 改行コード挿入処理(バイト基準)
     * @param value　　改行を入れたい文字列
     * @param　posLength　　何文字目で改行コード（折り返し）を入れるかの文字数
     * @return rtnValue 指定した文字数で改行コード（折り返し）がある文字列
     */
    public static String doInsertNewLine(String value, Integer posByte ){
        //受け取り文字列との差異計算用変数
        String cutvalue = null;
        
        //受け取った文字列が空なら文字列をそのまま返す
        if(value == null)
            return value;
        //改行文字の長さが文字列の長さ以下の場合
        else if(getBytes(value) <= posByte){
            
            // タグ対策
            value = value.replace('&','&amp;');
            value = value.replace('<','&lt;');
            value = value.replace('>','&gt;');
            
            return value;
        }
        
        //rtnValueに、受け取った文字列の初めから改行バイト数までの文字列を代入する
        String subValue = substringB(value, posByte);
        String rtnValue = subValue + '＜ｂｒ/＞';
        
        //改行文字長から文字列の長さまでのループ
        for(Integer i = posByte; i < getBytes(Value); i++){
            System.debug(rtnValue);    
            
            //iを改行バイト数で割った余りが0なら
            if( Math.mod( i, posByte ) == 0 ){
                //文字列の長さが、iと改行バイト数を足した長さより大きければ
                if( getBytes(value) > i + posByte ){
                    
                    //cutValueに、rtnValueとvalueの差異を代入
                    cutValue = subValue.difference(value);
                    subValue += substringB(cutValue, posByte );
                    rtnValue += substringB(cutValue, posByte ) + '＜ｂｒ/＞';                 
                    
                //文字列の長さが、iと改行バイト数を足した長さより小さければ
                }else{
                    //rtnValueに、
                    cutValue = subValue.difference(value);
                    rtnValue += cutValue;
                }
            }
        }
        
        // タグ対策
        rtnValue = rtnValue.replace('&','&amp;');
        rtnValue = rtnValue.replace('<','&lt;');
        rtnValue = rtnValue.replace('>','&gt;');
        
        rtnValue = rtnValue.replace('＜ｂｒ/＞','<br/>');
        return rtnValue;
    }
    

    
    /**
     * 改行コード挿入処理
     * @param value　　改行を入れたい文字列
     * @param　posLength　　何文字目で改行コード（折り返し）を入れるかの文字数
     * @return rtnValue 指定した文字数で改行コード（折り返し）がある文字列
     */
    public static String doInsertNewLineB(String value, Integer posByte ){
        //受け取り文字列との差異計算用変数
        String cutvalue = null;
        
        //受け取った文字列が空、もしくは改行文字の長さが文字列の長さ以下なら文字列をそのまま返す
        if(value == null || getBytes(value) <= posByte) return value;
        
        //rtnValueに、受け取った文字列の初めから改行バイト数までの文字列を代入する
        String subValue = substringB(value, posByte);
        String rtnValue = subValue + '\n';
        
        //改行文字長から文字列の長さまでのループ
        for(Integer i = posByte; i < getBytes(Value); i++){
            System.debug(rtnValue);    
            
            //iを改行バイト数で割った余りが0なら
            if( Math.mod( i, posByte ) == 0 ){
                //文字列の長さが、iと改行バイト数を足した長さより大きければ
                if( getBytes(value) > i + posByte ){
                    
                    //cutValueに、rtnValueとvalueの差異を代入
                    cutValue = subValue.difference(value);
                    subValue += substringB(cutValue, posByte );
                    rtnValue += substringB(cutValue, posByte ) + '\n';                 
                    
                //文字列の長さが、iと改行バイト数を足した長さより小さければ
                }else{
                    //rtnValueに、
                    cutValue = subValue.difference(value);
                    rtnValue += cutValue;
                }
            }
        }

        return rtnValue;
    }
    
    /**
     * 指定された文字列の左から指定文字数分を切り出します
     * @params value 対象の文字列
     * @params length 取得する文字数
     * @return 切り出された文字列
     */
    public static String left(String value, Integer length) {
        if (Strings.isNullOrEmpty(value) || value.length() <= length) return value;
        return value.substring(0, length);
    }
}