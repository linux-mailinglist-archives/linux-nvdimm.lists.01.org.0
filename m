Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1A30859C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 Jan 2021 07:24:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BEA2100EAB70;
	Thu, 28 Jan 2021 22:24:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D877100EAB6F
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 22:24:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l18so5806023pji.3
        for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 22:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Bd6R58wUJvAcnB/Gl2aPwFx5YSMoLj1S3qRYt9x/ML8=;
        b=PcYRZnIo1JKsnac6Zf97qLmUi+vf2BZpVMLY9ccn+E+S/B5N0OyAXc13h2blesLVpx
         mVX/z2oZHEfRJcZ5mRwriR2x9PCMSs8kVVp97vao0+oujgcJR1xelNFoKYRBrpEEC04E
         X/Rez2AhYY5f0UnI8F2ZgDbafbrK0VKlYwNpXM+98u+wnXB4+SvxJxRrqvnwjc/Au384
         2AxgfIPDLH16fAMO1jmXGSuK75ok7RqB4DPZ7poYEZrJo7qzkc/gckmj1z17n+IahmxA
         CEpG8EtSuywiGzq35TpBr78qc62YZpt3megkWHAgab6f06GhTzoLeJkiurbzeNytv0lm
         0BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Bd6R58wUJvAcnB/Gl2aPwFx5YSMoLj1S3qRYt9x/ML8=;
        b=dSbZd6eIUj5SqJJ8Kc2TIIqUr/gwpLGWEGYpsfGJ2zkBlZian7ks/0spjO0oJat1VL
         Cc4ypxSMvAiP/mQuPYMXHHy5RtSXPXiogauo531AXW9IFIoqbgiRZph+fpqsjj+aDqFu
         zlrnZhOIqVOQpNKXjocwBRwfLizyDj7Q+nrL0AGWK2Zbxb6KHCwKSi5vv2v4SXvWltjH
         ZGVlmk0pyw8WwSwFeH9bFfo8+ce3Ncljf9WLHYpTaVqYoQxyUTpHmDJQTzPs7NAaFHdb
         8HC+TKtcaggFWjveFwLC9/hg1Jyh3u86hsACmMK9X8SosUOkH1z/sKI3DglPueMDotiG
         j2ZA==
X-Gm-Message-State: AOAM531k6/xLzq77PTz42xjEoir2R+UdapOhT7awQux7g8vyODtHTT4K
	6I9DhFaPpGCU2xhelbK5q2O6HQ==
X-Google-Smtp-Source: ABdhPJwxC5OTicCqM25MKPmljQoJI/oYcyerAR5K4buUbEvUyFbBHH9tlVIjrOtXdpqYr6HkP5t7KQ==
X-Received: by 2002:a17:90b:19c7:: with SMTP id nm7mr3211525pjb.20.1611901474470;
        Thu, 28 Jan 2021 22:24:34 -0800 (PST)
Received: from localhost ([2409:4072:6d15:137:55da:c919:236a:4ad6])
        by smtp.gmail.com with ESMTPSA id cu5sm6525168pjb.7.2021.01.28.22.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:24:33 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl 5/5] Use page size as alignment value
In-Reply-To: <CAPcyv4inaEKt4s5vNGsbfidCz+biWJk6QTLyOMWB05iFreOMfA@mail.gmail.com>
References: <20201222042240.2983755-1-santosh@fossix.org>
 <20201222042516.2984348-1-santosh@fossix.org>
 <20201222042516.2984348-5-santosh@fossix.org>
 <CAPcyv4inaEKt4s5vNGsbfidCz+biWJk6QTLyOMWB05iFreOMfA@mail.gmail.com>
Date: Fri, 29 Jan 2021 11:54:30 +0530
Message-ID: <87wnvwuuox.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: TFZCU4GALX4ZD6UF4CHWXRFHZIH472PP
X-Message-ID-Hash: TFZCU4GALX4ZD6UF4CHWXRFHZIH472PP
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TFZCU4GALX4ZD6UF4CHWXRFHZIH472PP/>
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
>> The alignment sizes passed to ndctl in the tests are all hardcoded to 4k,
>> the default page size on x86. Change those to the default page size on that
>> architecture (sysconf/getconf). No functional changes otherwise.
>>
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> ---
>>  test/dpa-alloc.c    | 23 ++++++++++++++---------
>>  test/multi-dax.sh   |  6 ++++--
>>  test/sector-mode.sh |  4 +++-
>>  3 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
>> index 10af189..ff6143e 100644
>> --- a/test/dpa-alloc.c
>> +++ b/test/dpa-alloc.c
>> @@ -48,12 +48,13 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>>         struct ndctl_region *region, *blk_region = NULL;
>>         struct ndctl_namespace *ndns;
>>         struct ndctl_dimm *dimm;
>> -       unsigned long size;
>> +       unsigned long size, page_size;
>>         struct ndctl_bus *bus;
>>         char uuid_str[40];
>>         int round;
>>         int rc;
>>
>> +       page_size = sysconf(_SC_PAGESIZE);
>>         /* disable nfit_test.1, not used in this test */
>>         bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
>>         if (!bus)
>> @@ -134,11 +135,11 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>>                         return rc;
>>                 }
>>                 ndctl_namespace_disable_invalidate(ndns);
>> -               rc = ndctl_namespace_set_size(ndns, SZ_4K);
>> +               rc = ndctl_namespace_set_size(ndns, page_size);
>>                 if (rc) {
>> -                       fprintf(stderr, "failed to init %s to size: %d\n",
>> +                       fprintf(stderr, "failed to init %s to size: %lu\n",
>>                                         ndctl_namespace_get_devname(ndns),
>> -                                       SZ_4K);
>> +                                       page_size);
>>                         return rc;
>>                 }
>>                 namespaces[i].ndns = ndns;
>> @@ -160,7 +161,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>>                 ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
>>                 if (i % ARRAY_SIZE(namespaces) == 0)
>>                         round++;
>> -               size = SZ_4K * round;
>> +               size = page_size * round;
>>                 rc = ndctl_namespace_set_size(ndns, size);
>>                 if (rc) {
>>                         fprintf(stderr, "%s: set_size: %lx failed: %d\n",
>> @@ -176,7 +177,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>>         i--;
>>         round++;
>>         ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
>> -       size = SZ_4K * round;
>> +       size = page_size * round;
>>         rc = ndctl_namespace_set_size(ndns, size);
>>         if (rc) {
>>                 fprintf(stderr, "%s failed to update while labels full\n",
>> @@ -185,7 +186,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>>         }
>>
>>         round--;
>> -       size = SZ_4K * round;
>> +       size = page_size * round;
>>         rc = ndctl_namespace_set_size(ndns, size);
>>         if (rc) {
>>                 fprintf(stderr, "%s failed to reduce size while labels full\n",
>> @@ -279,8 +280,12 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>>
>>         available_slots = ndctl_dimm_get_available_labels(dimm);
>>         if (available_slots != default_available_slots - 1) {
>> -               fprintf(stderr, "mishandled slot count\n");
>> -               return -ENXIO;
>> +               fprintf(stderr, "mishandled slot count (%u, %u)\n",
>> +                       available_slots, default_available_slots - 1);
>> +
>> +               /* TODO: fix it on non-acpi platforms */
>> +               if (ndctl_bus_has_nfit(bus))
>> +                       return -ENXIO;
>
> This change seems unrelated to page size fixups. Care to break it out?

Sure Dan, I will add the API to check for DIMM error state flags too. Thanks for
the review, I will send a v2 soon.

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
