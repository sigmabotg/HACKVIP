#import <Foundation/Foundation.h>

// --- CHIÊU 1: HACK BỘ NHỚ LƯU TRỮ (NSUserDefaults) ---
%hook NSUserDefaults
- (BOOL)boolForKey:(NSString *)defaultName {
    NSString *key = [defaultName lowercaseString];
    if ([key containsString:@"vip"] || 
        [key containsString:@"premium"] || 
        [key containsString:@"pro"] || 
        [key containsString:@"unlock"] || 
        [key containsString:@"purchased"] ||
        [key containsString:@"subscribe"]) {
        return YES;
    }
    return %orig;
}
%end

// --- CHIÊU 2: ĐOÁN MÒ CÁC HÀM VIP PHỔ BIẾN ---
// (Nếu app không có các hàm này, dylib sẽ tự động bỏ qua, không gây lỗi)
%hook UserInfo
- (BOOL)isVIP { return YES; }
- (BOOL)isPro { return YES; }
- (BOOL)hasPremium { return YES; }
%end

%hook AppManager
- (BOOL)isVIP { return YES; }
%end

%hook AccountManager
- (BOOL)isPremium { return YES; }
%end
