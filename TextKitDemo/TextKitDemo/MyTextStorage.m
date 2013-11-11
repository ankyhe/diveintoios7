//
//  MyTextStorage.m
//  TextKitDemo
//
//  Created by AnkyHe on 11/11/13.
//  Copyright (c) 2013 Gery. All rights reserved.
//

#import "MyTextStorage.h"

NSString * const DefaultAttributeName = @"MyTextStorageDefatulAttribute";

@interface MyTextStorage() {
    NSMutableAttributedString *_backStorage;
    BOOL _needUpdate;
}

@end

@implementation MyTextStorage
- (id)init
{
    self = [super init];
    if (self) {
        _backStorage = [[NSMutableAttributedString alloc] init];
    }
    return self;
}

- (NSString *)string
{
    return [_backStorage string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)index effectiveRange:(NSRangePointer)aRange
{
    return [_backStorage attributesAtIndex:index effectiveRange:aRange];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [_backStorage replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes
           range:range
  changeInLength:str.length - range.length];
    _needUpdate = YES;
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    [_backStorage setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    _needUpdate = YES;
}

- (void)processEditing
{
    if (_needUpdate) {
        _needUpdate = NO;
        [self performReplacementsForCharacterChangeInRange:self.editedRange];
        
    }
    [super processEditing];
}

- (void)performReplacementsForCharacterChangeInRange:(NSRange)changedRange
{
    NSRange extendedRange = NSUnionRange(changedRange, [[_backStorage string]
                                                        lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [[_backStorage string]
                                                lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    [self applyStylesToRange:extendedRange];
}

- (void)applyStylesToRange:(NSRange)range
{
    NSDictionary *defaultAttribute = self.tokens[DefaultAttributeName];
    [[_backStorage string] enumerateSubstringsInRange:range
                                              options:NSStringEnumerationByWords
                                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                               NSDictionary *attributeForToken = self.tokens[substring];
                                               if (!attributeForToken) {
                                                   attributeForToken = defaultAttribute;
                                               }
                                               if (attributeForToken) {
                                                   [self addAttributes:attributeForToken range:substringRange];
                                               }
                                           }];
}



@end
