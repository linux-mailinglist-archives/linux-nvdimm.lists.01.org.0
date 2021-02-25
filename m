Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC144324A42
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 06:53:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEF5B100EBB9E;
	Wed, 24 Feb 2021 21:53:16 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C501F100EBB95
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 21:53:14 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so3064967pgl.10
        for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 21:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=tDtgnNetCa0Rr4gcVkiGZBijVJNLZPXX/yIyvvgw5f0=;
        b=aAoFxMUVxGcKEa7IJzZuwHHx1CwgJWvSzVFz3qCR+TAvASF9PfK7we6+qam4LCQglf
         PEZLXZLRmN0EnNDvuHxOLZeRhWXr9m7E9r8u6+0HQmr/aXvOEuWjs+HcNzMrpfYwaSWV
         w5R6lRYW518GmmoFcPYHwBh90fozjXujp1ca52oUNdZIEfk/O1R3U3o6oFGpfFA2lh+T
         NNNFFWGqwyyRtm8o0NThsouVMM5BRaXPVaZ3dKmk+3SiVaFNUPabItkaBbuuPslO6QJc
         xjNRifZsDEeVuoz4tCOVPh8oDWZy98S0V4bdF0Mh41FsbH+sfFPUwFgsvErElo7Ztr0Q
         rIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tDtgnNetCa0Rr4gcVkiGZBijVJNLZPXX/yIyvvgw5f0=;
        b=GP6WVQ1uv3eaSHSTeFKMmtrUYH4fnXQLLsabRfPUF5tTEo3w0UMVni5w7Zt+IsqQjz
         knnTPUrbZb+M9hWap73KTxup1YKLGa7c8zKJpk3eL4d4HrWaQVpDfUeDnS+0977Wr3Zm
         j0lbdb3OzUHMrSSWsFanoxziSc9ln9AKXkbxLpAGh7fBVeTQ5oIORvxCYxGKS3Gm/ToT
         diXXogOsMj8nTKEZTEYIygSFBcYQ4qOyQ40dNtbDjc2NxoP+YQxRkQ2gNQAaQWvpDt1a
         UGZ/6SbQghaZJ66259ik4KWvMT0pEoJ0u7hUKPuGH6/4/OKb2sLJ4k2rrAoGBNbKK6D+
         LlVg==
X-Gm-Message-State: AOAM533j8v2jWQHTI0j89LQhjUB3a97id+/txSE19fHOP9XmBcbk7d0n
	2sJC811XEkJdeZMUiCjLT9SZwg==
X-Google-Smtp-Source: ABdhPJxFvCaPxz0QZvgSQC0VqTejE0AW2J+JVUKMpFq6GE6cSGqit3B5VgGz+litslWaIdGkIutVgQ==
X-Received: by 2002:aa7:9298:0:b029:1ed:fd64:e6b7 with SMTP id j24-20020aa792980000b02901edfd64e6b7mr1664271pfa.5.1614232394069;
        Wed, 24 Feb 2021 21:53:14 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id m5sm4210784pgj.11.2021.02.24.21.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 21:53:13 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl 3/5] papr: Add support to parse save_fail flag for dimm
In-Reply-To: <CAPcyv4jv-+gFP68RKD57+=QhT_SUWqXPJ4qFgmVZfVgNkVESCg@mail.gmail.com>
References: <20201222042240.2983755-1-santosh@fossix.org>
 <20201222042516.2984348-1-santosh@fossix.org>
 <20201222042516.2984348-3-santosh@fossix.org>
 <CAPcyv4jv-+gFP68RKD57+=QhT_SUWqXPJ4qFgmVZfVgNkVESCg@mail.gmail.com>
Date: Thu, 25 Feb 2021 11:23:10 +0530
Message-ID: <87pn0oelrt.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: DO72BUGOI3PULOJH54MRYQVLHNJO4CDE
X-Message-ID-Hash: DO72BUGOI3PULOJH54MRYQVLHNJO4CDE
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DO72BUGOI3PULOJH54MRYQVLHNJO4CDE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Dec 21, 2020 at 8:26 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>>
>> This will help in getting the dimm fail tests to run on papr family too.
>> Also add nvdimm_test compatibility string for recognizing the test module.
>>
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> ---
>>  ndctl/lib/libndctl.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
>> index 5f09628..3fb3aed 100644
>> --- a/ndctl/lib/libndctl.c
>> +++ b/ndctl/lib/libndctl.c
>> @@ -815,6 +815,8 @@ static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
>>                         dimm->flags.f_restore = 1;
>>                 else if (strcmp(start, "smart_notify") == 0)
>>                         dimm->flags.f_smart = 1;
>> +               else if (strcmp(start, "save_fail") == 0)
>> +                       dimm->flags.f_save = 1;
>>                 start = end + 1;
>>         }
>>         if (end != start)
>> @@ -1044,7 +1046,8 @@ NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
>>         if (sysfs_read_attr(bus->ctx, bus->bus_buf, buf) < 0)
>>                 return 0;
>>
>> -       return (strcmp(buf, "ibm,pmemory") == 0);
>> +       return (strcmp(buf, "ibm,pmemory") == 0 ||
>> +               strcmp(buf, "nvdimm_test") == 0);
>
> A bit unfortunate to leak test details into the production path,
> especially when nvdimm_test is meant to be generic. It seems what you
> really want is a generic way to determine if dimm supports the common
> error state flags, right? I'd add an api for that and say yes for nfit
> and papr.

Sorry to get to this late.

Though I would like it to be generic, there is some advantage of code reuse if
it's part of the PAPR_FAMILY.

So the idea in the above code is to determine which flag parsing code to call,
either parse_nfit_mem_flags or parse_papr_flags. Or I could write a new function
if the bus is of neither type. But that would again want me to duplicate error
inject related code, and may be other paths too.

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
