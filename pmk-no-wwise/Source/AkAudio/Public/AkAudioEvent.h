#pragma once

#include "CoreMinimal.h"
#include "UObject/Object.h"
#include "AkAudioEvent.generated.h"

/**
 * Пустая заглушка вместо Wwise-плагина.
 * Существует только чтобы класс /Script/AkAudio.AkAudioEvent существовал:
 * Pal-заглушки кита объявляют UPROPERTY-указатели этого типа, а cooked-ассеты
 * игры ссылаются на него по имени. Никогда не исполняется.
 */
UCLASS()
class AKAUDIO_API UAkAudioEvent : public UObject
{
    GENERATED_BODY()
};
