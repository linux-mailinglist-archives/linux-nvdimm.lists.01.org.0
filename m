Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5BC365A5A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 15:39:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC945100F224E;
	Tue, 20 Apr 2021 06:39:44 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5C855100ED484
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 06:39:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso1350548pjb.0
        for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=TURTItiC11pYJkHH0o60oVDJd9t7nZnMGY6KOaMv0x8=;
        b=Q0KZ/CgO0atEEVB5+kdaU85+Ez9w8l3FfaUdYoVjOm24ogeB0yjmvrZJfZIIFYiZ31
         7SzOTxW93CsA/VurWzRe/p+stm3zhWLCRr9vSGuFgfLeeRE8qmx3PYlrQ37jTjhVpZcP
         ChFUo+L1SlO3uP1OjBg75o4CiGvENKgbc8YyXexwihiEI4OelSd2CB5uyC85dzcpssAK
         MKZ6+DBu1GbjBHYu9+tUitpJPyWYKf752YvZ0v34aHr/SwgQs7WUNmEA0pc1sNA5QQyh
         RN1MkkJxhYVPZlpRpHdfXFSDiQlb7Xg3L3zpN1fimFGA55RwRVUwCfr1U9FGRFVZOgne
         F6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TURTItiC11pYJkHH0o60oVDJd9t7nZnMGY6KOaMv0x8=;
        b=F1A8ZYLfAMANrOPWke+dOW8aTCYxjmkofyw2pfsZ99ZcV2knVtjvWYKmStvFq1lExN
         fe5zEKhudREFH0gP6EjTm+aO67y6jc13aI5RHpiB3qXUb+Efkx6cWkDvt6VzWEi6ciTG
         M04q0wt3OE72sz+B1CUMx39PLVLQb+8CG4ZXmF+t4tGROTu5leQvStgVCX2GxFrtMYMt
         C1YlfAym87r/z+loFXPeot4SUO6bOKxZZwZudfTJVeevdmL9TQWlMFPoxb1laNdVG2c8
         bXcJy/8/0yUyrjXD1nwgBxrpfOQg79AF6a16CnH1byxxT3JdZZVpnjomc56A3HJsD5n3
         4FcA==
X-Gm-Message-State: AOAM531u6+wrUujGH7OlxBl8dVR20/YVwbXvySHUrFJ++adYqYtlOl+/
	GkVYAb08by6Eu6dVrG0LCTRONg==
X-Google-Smtp-Source: ABdhPJyq1D2Qx4Ck1SQz7xViLpO7AenHi/QoGKVS5uRZR4YBKnTpewlHOu2NvtCQ+NS29fMMriA/2g==
X-Received: by 2002:a17:90a:7893:: with SMTP id x19mr5223666pjk.3.1618925981881;
        Tue, 20 Apr 2021 06:39:41 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id jx20sm2591668pjb.41.2021.04.20.06.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:39:41 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Ira Weiny <ira.weiny@intel.com>, Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] libnvdimm.h: Remove duplicate struct declaration
In-Reply-To: <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
References: <20210419112725.42145-1-wanjiabing@vivo.com>
 <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
Date: Tue, 20 Apr 2021 19:09:35 +0530
Message-ID: <874kg1yt0o.fsf@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: AM3UCWW4JK6HVEYJ6CJG2LB3YB4AV7EK
X-Message-ID-Hash: AM3UCWW4JK6HVEYJ6CJG2LB3YB4AV7EK
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, kael_w@yeah.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AM3UCWW4JK6HVEYJ6CJG2LB3YB4AV7EK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ira,

Ira Weiny <ira.weiny@intel.com> writes:

> On Mon, Apr 19, 2021 at 07:27:25PM +0800, Wan Jiabing wrote:
>> struct device is declared at 133rd line.
>> The declaration here is unnecessary. Remove it.
>> 
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>  include/linux/libnvdimm.h | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> index 01f251b6e36c..89b69e645ac7 100644
>> --- a/include/linux/libnvdimm.h
>> +++ b/include/linux/libnvdimm.h
>> @@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
>>  
>>  struct nvdimm_bus;
>>  struct module;
>> -struct device;
>>  struct nd_blk_region;
>
> What is the coding style preference for pre-declarations like this?  Should
> they be placed at the top of the file?
>
> The patch is reasonable but if the intent is to declare right before use for
> clarity, both devm_nvdimm_memremap() and nd_blk_region_desc() use struct
> device.  So perhaps this duplicate is on purpose?

There are other struct device usage much later in the file, which doesn't have
any pre-declarations for struct device. So I assume this might not be on
purpose :-)

On a side note, types.h can also be removed, since it's already included in
kernel.h.

Santosh

>
> Ira
>
>>  struct nd_blk_region_desc {
>>  	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
>> -- 
>> 2.25.1
>> 
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
