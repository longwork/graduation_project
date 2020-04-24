package wimi.graduation.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author Long WenChao
 * 时间的工具类
 */
public class DateUtil {
    private static final TimeZone TIME_ZONE = TimeZone.getTimeZone("GMT+08:00");
    private static final Log log = LogFactory.getLog(DateUtil.class);

    /**
     * @param date 当前日期值
     * @param day  推移的天
     * @return date时间加天数的日期
     * @author Mengfw
     */
    public static String addDate2(String date, int day) {
        GregorianCalendar calendar = new GregorianCalendar();
        calendar.setTime(getDate(date, "yyyyMMdd"));
        calendar.add(GregorianCalendar.DAY_OF_MONTH, day);
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        return format.format(calendar.getTime());
    }

    /**
     * @param msel 毫秒时间
     * @return 毫秒时间 所对应的"yyyy-MM-dd HH:mm"格式的日期
     */

    public static String formatTime(long msel) {
        Date date = new Date(msel);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        formatter.setTimeZone(TIME_ZONE);
        return formatter.format(date);
    }

    /**
     * 将一个字符串的日期描述转换为java.util.Date对象
     *
     * @param strDate 字符串的日期描述
     * @param format  字符串的日期格式，比如:“yyyy-MM-dd HH:mm”
     * @return 字符串转换的日期对象java.util.Date
     */
    public static Date getDate(String strDate, String format) {
        if (strDate == null || "".equals(strDate.trim())) {
            strDate = getCurrentTime(format);
        }

        SimpleDateFormat formatter = new SimpleDateFormat(format);

        Date date;
        try {
            date = formatter.parse(strDate);
        } catch (ParseException e) {
            date = null;
        }

        return date;
    }

    /**
     * 得到系统当前时间
     *
     * @param format 指定的时间显示格式，比如:“yyyy-MM-dd HH:mm”
     * @return 按指定格式显示的当前日期
     */
    public static String getCurrentTime(String format) {
        return new SimpleDateFormat(format).format(new Date());
    }

    /**
     * 得到系统当前的年
     *
     * @return 年
     */
    public static int getCurrentYear() {
        GregorianCalendar calendar = new GregorianCalendar();
        return calendar.get(Calendar.YEAR);
    }

    /**
     * 取两日期之间的天数间隔
     *
     * @param strDate1 格式:yyyymmdd
     * @param strDate2 格式:yyyymmdd
     * @return 天数
     */
    public static int getDistance(String strDate1, String strDate2) {
        int distance = 0;
        Date date1 = getDate(strDate1, "yyyyMMdd");
        Date date2 = getDate(strDate2, "yyyyMMdd");
        distance = (int) ((date2.getTime() - date1.getTime()) / 1000 / 60 / 60 / 24);
        return distance;
    }

    /**
     * 取得上一个星期的第一天 changes1.1-00 统计内容增加上周的平均值
     * <p>
     * 指定日期。
     *
     * @return 上一个星期的第一天(YYYYMMDD)
     */
    public static synchronized Date getFirstDayOfPrevWeek() {
        /**
         * 详细设计： 1.调用getNextWeek设置当前时间 2.以1为基础，调用getFirstDayOfWeek
         */
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
        gc.setTime(new Date());
        gc.setTime(getPrevWeek(gc.getTime()));
        gc.setTime(format.parse(getFirstDayOfWeek(Integer.parseInt(format
                .format(gc.getTime())))
                + "", new ParsePosition(0)));
        return gc.getTime();
    }

    /**
     * 取得指定日期的所处星期的第一天 changes1.1-00 统计内容增加上周的平均值
     *
     * @param date 指定日期。
     * @return 指定日期的所处星期的第一天
     */
    public static synchronized int getFirstDayOfWeek(int date) {
        /**
         * 详细设计： 1.如果date是星期日，则减0天 2.如果date是星期一，则减1天 3.如果date是星期二，则减2天
         * 4.如果date是星期三，则减3天 5.如果date是星期四，则减4天 6.如果date是星期五，则减5天
         * 7.如果date是星期六，则减6天
         */
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String strDate = date + "";
        Date day = format.parse(strDate, new ParsePosition(0));
        GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
        gc.setTime(day);
        switch (gc.get(Calendar.DAY_OF_WEEK)) {

            case (Calendar.SUNDAY):
                gc.add(Calendar.DATE, 0);
                break;
            case (Calendar.MONDAY):
                gc.add(Calendar.DATE, -1);
                break;
            case (Calendar.TUESDAY):
                gc.add(Calendar.DATE, -2);
                break;
            case (Calendar.WEDNESDAY):
                gc.add(Calendar.DATE, -3);
                break;
            case (Calendar.THURSDAY):
                gc.add(Calendar.DATE, -4);
                break;
            case (Calendar.FRIDAY):
                gc.add(Calendar.DATE, -5);
                break;
            case (Calendar.SATURDAY):
                gc.add(Calendar.DATE, -6);
                break;
            default:
        }
        return Integer.parseInt(format.format(gc.getTime()));
    }

    /**
     * 取得指定日期的上一个星期 changes1.1-00 统计内容增加上周的平均值
     *
     * @param date 指定日期。
     * @return 指定日期的上一个星期
     */
    public static synchronized Date getPrevWeek(Date date) {
        /*
         * 详细设计： 1.指定日期加7天
         */
        GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
        gc.setTime(date);
        gc.add(Calendar.DATE, -7);
        return gc.getTime();
    }

    /**
     * 日期转换
     *
     * @param strDate 输入日期
     * @return date
     */
    public static Date isToDate(String strDate) {
        Date date = new Date();
        SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
        try {
            date = d.parse(strDate);
        } catch (ParseException e) {
            //
        }
        return date;
    }

    /**
     * 得到现在时间 yyyy-MM-dd HH:mm:ss
     * YD
     */
    public static String getNowDateSS() {
        SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return d.format(new Date());
    }

    public static String format(String format, Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat(format);
        return formatter.format(date);
    }

    /**
     * 得到系统当前日期所在周的第一天
     *
     * @param format
     * @return
     */
    public static String getFirstDayOfWeek(String format) {
        SimpleDateFormat df = new SimpleDateFormat(format);
        Calendar c = Calendar.getInstance(Locale.CHINA);
        c.setFirstDayOfWeek(Calendar.MONDAY);
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        return df.format(c.getTime());
    }

    /**
     * 得到系统当前月
     *
     * @return 当前月
     */
    public static int getCurrentMonth() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM");
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(new Date());
        String strMonth = dateFormat.format(cal.getTime());
        return Integer.parseInt(strMonth);
    }

    /**
     * 从字符串日期描述中得到月份
     *
     * @param strDate 字符串日期描述
     * @param format  字符串的日期格式，比如:“yyyy-MM-dd HH:mm”
     * @return 字符串中的月份
     */
    public static int getMonth(String strDate, String format) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM");
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(getDate(strDate, format));
        String strMonth = dateFormat.format(cal.getTime());
        return Integer.parseInt(strMonth);
    }

    public static String addDay(int day, String sourcedate, String format) {
        String dateBack = "";
        SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        Date dates;
        try {
            dates = dateFormat.parse(sourcedate);
            Calendar date = Calendar.getInstance();
            date.setTime(dates);
            date.add(Calendar.DAY_OF_YEAR, day);
            dateBack = dateFormat.format(date.getTime());
        } catch (ParseException e) {
            log.error(e.toString());
        }

        return dateBack;
    }

    /**
     * 计算两个日期间的天数
     *
     * @param fromDate 起始日期
     * @param toDate   结束日期
     * @return
     * @throws ParseException
     */
    public static int dateDiff(String fromDate, String toDate)
            throws ParseException {
        int days = 0;

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date from = df.parse(fromDate);
        Date to = df.parse(toDate);
        days = (int) Math.abs((to.getTime() - from.getTime())
                / (24 * 60 * 60 * 1000)) + 1;
        return days;
    }

    public static String getFirstDayOfMonth(String sourcedate, String format) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        Date date = null;
        try {
            date = dateFormat.parse(sourcedate);
        } catch (ParseException e) {
            log.error(e.toString());
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(calendar.get(Calendar.YEAR),
                calendar.get(Calendar.MONTH), 1);

        return dateFormat.format(calendar.getTime());
    }

    public static void main(String[] args) {
        try {
            int k = (dateDiff("2016-09-28 14:00:00", "2016-09-28 19:00:00") - 1);
            log.debug(k);
            String d = addDay(3, "2016-09-28 19:00:00", "yyyy-MM-dd");
            log.debug(d);
            String str = getFirstDayOfWeek("yyyy-MM-dd");
            log.debug(str);
            String startDate = DateUtil.addDay(0, "2016-10-11", "yyyy-MM") + "-01";
            log.debug(startDate);
            Calendar cal = Calendar.getInstance();
            int ka = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            log.debug(ka);
            String lastDateOfMonth = getFirstDayOfMonth("2016-10-11", "yyyy-MM-dd");
            log.debug(lastDateOfMonth);
            log.debug(getMonth("2016-09-11", "yyyy-MM-dd"));

        } catch (ParseException e) {
            log.error(e.toString());
        }
    }
}
