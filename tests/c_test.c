//
//  c_test.c
//  crc32c
//
//  Created by Adam Knight on 11/19/13.
//  Copyright (c) 2013 Adam Knight. All rights reserved.
//

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "crc32c.h"

uint32_t crc32c_oneshot(const void* base, uint32_t length)
{
    return crc32cFinish(crc32c(crc32cInit(), base, length));
}

int main (int argc, const char * argv[])
{
    char value[100] = "This is some text.";
    size_t len = strlen(value);
    
    uint32_t crc = 0;
    crc = crc32cInit();
    crc = crc32c(crc, &value, len);
    crc = crc32cFinish(crc);
    printf("CRC, rolling: %#x\n", crc);
    printf("CRC one-shot: %#x\n", crc32c_oneshot(value, len));
    
    static const char NUMBERS[] = "1234567890";
    static const char PHRASE[] = "The quick brown fox jumps over the lazy dog";
    
    crc = crc32c_oneshot(NUMBERS, 9);
    if (crc != 0xE3069283)
        printf("(NUMBERS, 9) Expected %#x; got %#x\n", 0xE3069283, crc);
    
    crc = crc32c_oneshot(NUMBERS+1, 8);
    if (crc != 0xBFE92A83)
        printf("(NUMBERS+1, 8) Expected %#x; got %#x\n", 0xBFE92A83, crc);
    
    crc = crc32c_oneshot(NUMBERS, 10);
    if (crc != 0xf3dbd4fe)
        printf("(NUMBERS, 10) Expected %#x; got %#x\n", 0xf3dbd4fe, crc);
    
    size_t len_s = strlen(PHRASE);
    crc = crc32c_oneshot(PHRASE, len_s);
    if (crc != 0x22620404)
        printf("(PHRASE, %zu) Expected %#x; got %#x\n", len_s, 0x22620404, crc);
    
    return 0;
}