Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEC234557D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Mar 2021 03:30:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2964100EB846;
	Mon, 22 Mar 2021 19:30:32 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59113100EB831
	for <linux-nvdimm@lists.01.org>; Mon, 22 Mar 2021 19:30:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x126so12714522pfc.13
        for <linux-nvdimm@lists.01.org>; Mon, 22 Mar 2021 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+YVFgC5GVnJ/gkmex9e0Xu8FuKKrJUnG/mNqLKZ4efQ=;
        b=q1ZZnEOgRoA6vhVrvNIAI7EJcROEg26OzX8dcoidZpwFFRBE8rQXORzB39Gvti6yp4
         Oz0sjk6dJWs2ptWOKRwkbLcHObrlb8t2EXIeChU+OMydz6+2JlK/mRfDg/Ox1qjVn97l
         za8Yrl0KUdvv72QlbH9wK7QLr4SiWaxFObWn5g2RQbj8EhYzjhihXoGdc2r7WFSS4Znn
         ptJ7xaYBGHRzAnUz+wVG3YziAH01HwLJvHVabHZhEYGliUti6z8EVtaVN9l28bKf3m3M
         cvSKMzpQg6AcEsu/ESJoOs96VmI9kdq93i/WnAAa/A9oIJ+c4oJCd2wEBlcYWbgTXiwZ
         9KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+YVFgC5GVnJ/gkmex9e0Xu8FuKKrJUnG/mNqLKZ4efQ=;
        b=C9cbjKxdPt87lVPsKVb1OC8N3N65tE0HuxfFWKFk37MmE27HYtW/Xk0kbiHiVZ1Bif
         Ume+3YGbpQOyykCvoVj9HupQfDpQQFvR94fAVOfKsQpxsrqMR5ri5lYlOa4D0mMprgo6
         QQjZBfv+xvDrvFOKA7VnhWUQKx7nhNwqu6iTa4AE9Pyq+PJSVFtoi/bY1Q/NQij+G+Ol
         v31bL7eiyMyYXGeXLnnyxqJ69tnflXP/+gOhDfZK3Sm3O41omY0/U+48uuECCcLMMTIB
         MUUfQk9MxMvcqgV3yTPiz4tSrTnK79Y1+wLWl8os3Y2ZG0sAHyYhU8+zZxwPHYB2s40n
         lF9w==
X-Gm-Message-State: AOAM532eOcJNq1/0XvxCGVqtSW0uCp/FXTz5GL8ocU6ccxV/e/m/6gIq
	j5pLPm5ZPf7m1Q/H/wk3y7FpRQ==
X-Google-Smtp-Source: ABdhPJxS3CflDvVSHKhEReY+Rutg7nyNfyIIWjMJMvFVNeEv1oUmwYvJKcraQMlHLjJ56fCdRpiBEw==
X-Received: by 2002:a17:902:b40e:b029:e6:837f:711 with SMTP id x14-20020a170902b40eb02900e6837f0711mr2672083plr.2.1616466628446;
        Mon, 22 Mar 2021 19:30:28 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id d5sm642135pjo.12.2021.03.22.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:30:27 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Ira Weiny <ira.weiny@intel.com>, Jiapeng Chong
 <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ndtest: Remove redundant NULL check
In-Reply-To: <20210322202029.GP3014244@iweiny-DESK2.sc.intel.com>
References: <1616407240-114077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210322202029.GP3014244@iweiny-DESK2.sc.intel.com>
Date: Tue, 23 Mar 2021 08:00:25 +0530
Message-ID: <87r1k61u0u.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: W6ECEJAIT4BWRXQBJLLA4RDFSRV7SLZJ
X-Message-ID-Hash: W6ECEJAIT4BWRXQBJLLA4RDFSRV7SLZJ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W6ECEJAIT4BWRXQBJLLA4RDFSRV7SLZJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi Ira,

Ira Weiny <ira.weiny@intel.com> writes:

> On Mon, Mar 22, 2021 at 06:00:40PM +0800, Jiapeng Chong wrote:
>> Fix the following coccicheck warnings:
>> 
>> ./tools/testing/nvdimm/test/ndtest.c:491:2-7: WARNING: NULL check before
>> some freeing functions is not needed.
>
> I don't think there is anything wrong with this patch specifically but why is
> buf not checked for null after the vmalloc?
>
> It seems to me that if size >= DIMM_SIZE and the vmalloc fails the gen pool
> allocation is going to be leaked.
>

If vmalloc fails, gen_pool_free will get called through ndtest_release_resource,
registered with devm_action. But we will still need to check for vmalloc fail.

I will fix that when I send my inject-error support for the driver.

Thanks,
Santosh

> Ira
>
>> 
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>>  tools/testing/nvdimm/test/ndtest.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
>> index 6862915..98b4a43 100644
>> --- a/tools/testing/nvdimm/test/ndtest.c
>> +++ b/tools/testing/nvdimm/test/ndtest.c
>> @@ -487,8 +487,7 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
>>  buf_err:
>>  	if (__dma && size >= DIMM_SIZE)
>>  		gen_pool_free(ndtest_pool, __dma, size);
>> -	if (buf)
>> -		vfree(buf);
>> +	vfree(buf);
>>  	kfree(res);
>>  
>>  	return NULL;
>> -- 
>> 1.8.3.1
>> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
