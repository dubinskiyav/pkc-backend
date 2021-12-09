package biz.gelicon.core.utils;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class UsefulUtils {


    public static <T> Collector<T, ?, List<T>> toListReversed() {
        return Collectors.collectingAndThen(Collectors.toList(), l -> {
            Collections.reverse(l);
            return l;
        });
    }

    public static int indexOf(int[] data, int sample) {
        for (int i = 0; i < data.length; i++) {
            if(data[i]==sample) {
                return i;
            }
        }
        return -1;
    }

    /**
     * Гененирует строку определенной длины
     * @param character
     * @param length
     * @return
     */
    public static String createString(char character, int length) {
        char[] chars = new char[length];
        Arrays.fill(chars, character);
        return new String(chars);
    }


    /**
     * Коллектор, допускающий null в value.
     * Автор https://stackoverflow.com/users/516188/emmanuel-touzery
     *
     * @param keyMapper
     * @param valueMapper
     * @param <T>
     * @param <K>
     * @param <U>
     * @return
     *
     *
     */
    public static <T, K, U> Collector<T, ?, Map<K, U>> toMapNullFriendly(
            Function<? super T, ? extends K> keyMapper,
            Function<? super T, ? extends U> valueMapper) {
        @SuppressWarnings("unchecked")
        U none = (U) new Object();
        return Collectors.collectingAndThen(
                Collectors.<T, K, U> toMap(keyMapper,
                        valueMapper.andThen(v -> v == null ? none : v)), map -> {
                    map.replaceAll((k, v) -> v == none ? null : v);
                    return map;
                });
    }
}
