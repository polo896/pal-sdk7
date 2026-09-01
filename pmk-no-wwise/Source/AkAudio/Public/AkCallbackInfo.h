#pragma once

#include "CoreMinimal.h"
#include "UObject/Object.h"
#include "AkCallbackInfo.generated.h"

/**
 * Пустая заглушка вместо Wwise-плагина.
 * Используется Pal-заглушками только как тип параметра C++-колбэков
 * и как параметр делегата FOnAkPostEventCallback.
 */
UCLASS()
class AKAUDIO_API UAkCallbackInfo : public UObject
{
    GENERATED_BODY()
};
