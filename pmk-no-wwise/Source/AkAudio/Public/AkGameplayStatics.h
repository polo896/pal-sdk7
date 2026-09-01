#pragma once

#include "CoreMinimal.h"
#include "AkCallbackInfo.h"
#include "AkGameplayStatics.generated.h"

/**
 * Стаб-заменитель заголовка AkGameplayStatics.h из Wwise-плагина.
 * Четыре звуковых Pal-заглушки кита подключают его ради типов ниже;
 * сами вызовы AkGameplayStatics:: в .cpp кита отсутствуют (проверено grep'ом),
 * поэтому достаточно типов и пустого объявления.
 */

UENUM(BlueprintType)
enum class EAkCallbackType : uint8
{
    EndOfEvent = 0,
    Marker = 1,
    Duration = 2,
    Other = 3,
};

DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(
    FOnAkPostEventCallback, EAkCallbackType, CallbackType, UAkCallbackInfo*, CallbackInfo);

class AkGameplayStatics
{
public:
    // намеренно пусто: Pal-код кита эти функции не вызывает
};
