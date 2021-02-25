Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE5324A45
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 06:54:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E7BA100EB84F;
	Wed, 24 Feb 2021 21:54:17 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1507C100EBB9E
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 21:54:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so2583100plg.13
        for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 21:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=z3BFKlLrB2F3Rs5Q4n2tzT3dBYARhDurxzpYyTA3R0A=;
        b=Zpvl13jxHxQGNksSTZcRWqDtbeiCh+UlZXb97zkMW2e6g7w2zAvr4Fg0yppweDJg8v
         BkhEb+RkL4cWDTj3hJwuE1T4UwWv2XbKsxaMGJJ2LCF5fztemRch5ZBULJs+vHb+2gcw
         IdajCuGplDAK5/1ecD6SWsYqjno8QKnQCUiKh75qTCy2q0NAoL4ocJ9ddYNEj+yOpkEp
         1SO9ghGVh47+hleS1IJTdHao2H/I6AO+7otF4NQYuIbjrk+CdJevOT/ljfVUPORPkkFq
         f3lqjWHRLxm4SzxjP6CfulxwWXlGvoRnuZh8FVD2UzBxLhOEFdKe/ZgJO/r3sTv8UZbL
         Vvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z3BFKlLrB2F3Rs5Q4n2tzT3dBYARhDurxzpYyTA3R0A=;
        b=eeVwiERqd9fQ/VGZc4p8dH9N4ILewYJ5SIHlfsH5UjSfFQfxUFhuxlznTXMlIstzIJ
         xyDLI+SR0/3Ihh8xlgxBpcO9L3N7w/Xm5y/NukmGIhV83ZNy0EkXr1CKmpnjcHlqkW9E
         sPy2TVRV/lw6QLBmQseCE65L6m2W7RWJJC9U8aWRq6JAr16mUx7pvg6VC0t8+uI6/ERV
         eyxB1vGkURqALQAwU0sOKMEmiTsgJpWQGudoP4mtANB1oD0HQM661fzj9jhhow1PbrN4
         B2O2phd4O4a5CMdtrcKUU1Esac3bz8PgbbxnhpeA2cQnYkB45TEzpgCW9mYArOyNKBQG
         uYmw==
X-Gm-Message-State: AOAM531+XKMqMA7Hkytbwz6K1amzX6/opefvD34USZNWpPsgIR8iThHl
	tteJ2oGEpEH5a6BbqHm5BoRnxw==
X-Google-Smtp-Source: ABdhPJw3SVBfNYciv1teFRHgt4I7HM1Zl4YUpNmh7XsdInIQxi2qS8owQXWzpLeCa7k9g0iwIPTXBg==
X-Received: by 2002:a17:902:9304:b029:e4:12f4:bdb0 with SMTP id bc4-20020a1709029304b02900e412f4bdb0mr1682919plb.55.1614232454653;
        Wed, 24 Feb 2021 21:54:14 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id b188sm4952000pfg.179.2021.02.24.21.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 21:54:14 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl 5/5] Use page size as alignment value
In-Reply-To: <CAPcyv4inaEKt4s5vNGsbfidCz+biWJk6QTLyOMWB05iFreOMfA@mail.gmail.com>
References: <20201222042240.2983755-1-santosh@fossix.org>
 <20201222042516.2984348-1-santosh@fossix.org>
 <20201222042516.2984348-5-santosh@fossix.org>
 <CAPcyv4inaEKt4s5vNGsbfidCz+biWJk6QTLyOMWB05iFreOMfA@mail.gmail.com>
Date: Thu, 25 Feb 2021 11:24:12 +0530
Message-ID: <87mtvselq3.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: K3XLVXWEY6BCCEVIUQLYOQU63UQQKPIQ
X-Message-ID-Hash: K3XLVXWEY6BCCEVIUQLYOQU63UQQKPIQ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K3XLVXWEY6BCCEVIUQLYOQU63UQQKPIQ/>
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

This change is not required, I have already fixed this up. Refactoring residue.

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
