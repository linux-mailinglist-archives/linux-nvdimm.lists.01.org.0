Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9323562E2
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Apr 2021 07:10:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E700C100ED4A2;
	Tue,  6 Apr 2021 22:10:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=209.85.216.51; helo=mail-pj1-f51.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A3D93100EF276
	for <linux-nvdimm@lists.01.org>; Tue,  6 Apr 2021 22:10:45 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso667133pjh.2
        for <linux-nvdimm@lists.01.org>; Tue, 06 Apr 2021 22:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=28Y6QISowK8t0Ned/4dFEDUu09YRSJtamLGp+wNbhbQ=;
        b=1LnCJKAuimF7pooah7PUy5C1ECw1U60126l3qgupBToxFB9Xf+2FFN1X1XiNo/2SD3
         kNvKjshINcgNfCvPH6epyJ91vSuZDGNdvd7G55Z/YtzyeaxgOJsW+rfAiFWPl08ZXa64
         9l9yIPGcHtrpiiaJ+uc/l14nrCrB2GR6q1ME5Z9LHgEZZcS/qWpTv+xnXH/2NIqZmEyE
         lgRxk8g3e8fFHLL+hIY6dC/zGEr6jfGiILrAhxHPNxd4k4cfXHK+zmjV6GOM+EVspRfB
         jKsSdupDpDIGmtTiQB+fViYqC9tLOSSvQNFodzXiWH8RTYOHk5osAxuuGqsQsG65TrMo
         iYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=28Y6QISowK8t0Ned/4dFEDUu09YRSJtamLGp+wNbhbQ=;
        b=hvo1ACXyn9kVvvj09b3lh2GH2MX0PdsO/Rc3vejCI9IrnFTfCyB+BzYUuORr9OpSJO
         B7D/TwFgIHRm5A6+4ETKp/CGl9T4UehWuNthqWdE0VHt2GOm35/n//BvxpBsgn8z+q5A
         1Zfbtx0SLA6uvGQWH9qFHIn0W/YLk+M6bRRJ2FmO+bYRpP7xf7MfE9M7Nyca0ynG02gS
         A84Ic5wRFvNiqd/EAqKkgOopp8tv2und8SluhAldDoQnuYgO0dtNASIqS2acJQ6uPkvE
         RHnFF6YDoY6s8efIfQkxgG9URkBAowuONjvc4gnjMCeM6DUp4RohTMhnszOxEmYRB0v5
         9P2g==
X-Gm-Message-State: AOAM530KfWAdH8UbwxAtSUNoKiZQwnQ3cWzAsRocF1GS/sX6ybTK+Z2T
	MTz+3pQXkF4Ph8nat+NN41odug==
X-Google-Smtp-Source: ABdhPJxOLT8tY/xVyHDKU37GWl7vxiOK1N39scYIbKEow7rH5JOKRu+1Tcb+tlBZqQcuiL/C0aztfA==
X-Received: by 2002:a17:90b:3704:: with SMTP id mg4mr1574474pjb.156.1617772185072;
        Tue, 06 Apr 2021 22:09:45 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id q10sm19854066pgs.44.2021.04.06.22.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 22:09:44 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux NVDIMM
 <linux-nvdimm@lists.01.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat
 <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/4] test: Don't skip tests if nfit modules are missing
In-Reply-To: <877dlg7was.fsf@linux.ibm.com>
References: <20210328021001.2340251-1-santosh@fossix.org>
 <20210328021001.2340251-2-santosh@fossix.org>
 <877dlg7was.fsf@linux.ibm.com>
Date: Wed, 07 Apr 2021 10:39:36 +0530
Message-ID: <87czv67ka7.fsf@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: BGZC2LI7WZO2UVPG5IV6GMOPT4QYGS2X
X-Message-ID-Hash: BGZC2LI7WZO2UVPG5IV6GMOPT4QYGS2X
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BGZC2LI7WZO2UVPG5IV6GMOPT4QYGS2X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Santosh Sivaraj <santosh@fossix.org> writes:
>
>> For NFIT to be available ACPI is a must, so don't fail when nfit modules
>> are missing on a platform that doesn't support ACPI.
>>
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> ---
>>  test.h                        |  2 +-
>>  test/ack-shutdown-count-set.c |  2 +-
>>  test/blk_namespaces.c         |  2 +-
>>  test/core.c                   | 30 ++++++++++++++++++++++++++++--
>>  test/dpa-alloc.c              |  2 +-
>>  test/dsm-fail.c               |  2 +-
>>  test/libndctl.c               |  2 +-
>>  test/multi-pmem.c             |  2 +-
>>  test/parent-uuid.c            |  2 +-
>>  test/pmem_namespaces.c        |  2 +-
>>  10 files changed, 37 insertions(+), 11 deletions(-)
>>
>> diff --git a/test.h b/test.h
>> index cba8d41..7de13fe 100644
>> --- a/test.h
>> +++ b/test.h
>> @@ -20,7 +20,7 @@ void builtin_xaction_namespace_reset(void);
>>  
>>  struct kmod_ctx;
>>  struct kmod_module;
>> -int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>> +int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>>  		struct ndctl_ctx *nd_ctx, int log_level,
>>  		struct ndctl_test *test);
>>  
>> diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
>> index fb1d82b..c561ff3 100644
>> --- a/test/ack-shutdown-count-set.c
>> +++ b/test/ack-shutdown-count-set.c
>> @@ -99,7 +99,7 @@ static int test_ack_shutdown_count_set(int loglevel, struct ndctl_test *test,
>>  	int result = EXIT_FAILURE, err;
>>  
>>  	ndctl_set_log_priority(ctx, loglevel);
>> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>>  	if (err < 0) {
>>  		result = 77;
>>  		ndctl_test_skip(test);
>> diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
>> index d7f00cb..f076e85 100644
>> --- a/test/blk_namespaces.c
>> +++ b/test/blk_namespaces.c
>> @@ -228,7 +228,7 @@ int test_blk_namespaces(int log_level, struct ndctl_test *test,
>>  
>>  	if (!bus) {
>>  		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
>> -		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
>> +		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
>>  		ndctl_invalidate(ctx);
>>  		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
>>  		if (rc < 0 || !bus) {
>> diff --git a/test/core.c b/test/core.c
>> index cc7d8d9..44cb277 100644
>> --- a/test/core.c
>> +++ b/test/core.c
>> @@ -11,6 +11,7 @@
>>  #include <util/log.h>
>>  #include <util/sysfs.h>
>>  #include <ndctl/libndctl.h>
>> +#include <ndctl/ndctl.h>
>>  #include <ccan/array_size/array_size.h>
>>  
>>  #define KVER_STRLEN 20
>> @@ -106,11 +107,11 @@ int ndctl_test_get_skipped(struct ndctl_test *test)
>>  	return test->skip;
>>  }
>>  
>> -int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>> +int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>>  		struct ndctl_ctx *nd_ctx, int log_level,
>>  		struct ndctl_test *test)
>>  {
>> -	int rc;
>> +	int rc, family = -1;
>>  	unsigned int i;
>>  	const char *name;
>>  	struct ndctl_bus *bus;
>> @@ -127,10 +128,30 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>>  		"nd_e820",
>>  		"nd_pmem",
>>  	};
>> +	char *test_env;
>>  
>>  	log_init(&log_ctx, "test/init", "NDCTL_TEST");
>>  	log_ctx.log_priority = log_level;
>>  
>> +	/*
>> +	 * The following two checks determine the platform family. For
>> +	 * Intel/platforms which support ACPI, check sysfs; for other platforms
>> +	 * determine from the environment variable NVDIMM_TEST_FAMILY
>> +	 */
>> +	if (access("/sys/bus/acpi", F_OK) == 0) {
>> +		if (errno == ENOENT)
>> +			family = NVDIMM_FAMILY_INTEL;
>> +	}
>> +
>> +	test_env = getenv("NDCTL_TEST_FAMILY");
>> +	if (test_env && strcmp(test_env, "PAPR") == 0)
>> +		family = NVDIMM_FAMILY_PAPR;
>
> I am wondering whether it is confusing to call this as
> NVDIMM_FAMILY_PAPR. If you are looking at a platform agnoistic family we
> should probably name it accordingly. Maybe NVDIMM_FAMILY_TEST ?

This is intentional, so that we can reuse PAPR code for SMART, health and error
injection tests. Otherwise we will end up copying major parts of the code. Also
I am not sure that we should create a separate family for tests.

Thanks,
Santosh

>
>
>> +
>> +	if (family == -1) {
>> +		log_err(&log_ctx, "Cannot determine NVDIMM family\n");
>> +		return -ENOTSUP;
>> +	}
>> +
>>  	*ctx = kmod_new(NULL, NULL);
>>  	if (!*ctx)
>>  		return -ENXIO;
>> @@ -185,6 +206,11 @@ retry:
>>  
>>  		path = kmod_module_get_path(*mod);
>>  		if (!path) {
>> +			if (family != NVDIMM_FAMILY_INTEL &&
>> +			    (strcmp(name, "nfit") == 0 ||
>> +			     strcmp(name, "nd_e820") == 0))
>> +				continue;
>> +
>>  			log_err(&log_ctx, "%s.ko: failed to get path\n", name);
>>  			break;
>>  		}
>> diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
>> index e922009..0b3bb7a 100644
>> --- a/test/dpa-alloc.c
>> +++ b/test/dpa-alloc.c
>> @@ -289,7 +289,7 @@ int test_dpa_alloc(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
>>  		return 77;
>>  
>>  	ndctl_set_log_priority(ctx, loglevel);
>> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>>  	if (err < 0) {
>>  		ndctl_test_skip(test);
>>  		fprintf(stderr, "nfit_test unavailable skipping tests\n");
>> diff --git a/test/dsm-fail.c b/test/dsm-fail.c
>> index 9dfd8b0..0a6383d 100644
>> --- a/test/dsm-fail.c
>> +++ b/test/dsm-fail.c
>> @@ -346,7 +346,7 @@ int test_dsm_fail(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
>>  	int result = EXIT_FAILURE, err;
>>  
>>  	ndctl_set_log_priority(ctx, loglevel);
>> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>>  	if (err < 0) {
>>  		result = 77;
>>  		ndctl_test_skip(test);
>> diff --git a/test/libndctl.c b/test/libndctl.c
>> index 24d72b3..0e88fce 100644
>> --- a/test/libndctl.c
>> +++ b/test/libndctl.c
>> @@ -2692,7 +2692,7 @@ int test_libndctl(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
>>  	daxctl_set_log_priority(daxctl_ctx, loglevel);
>>  	ndctl_set_private_data(ctx, test);
>>  
>> -	err = nfit_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
>> +	err = ndctl_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
>>  	if (err < 0) {
>>  		ndctl_test_skip(test);
>>  		fprintf(stderr, "nfit_test unavailable skipping tests\n");
>> diff --git a/test/multi-pmem.c b/test/multi-pmem.c
>> index 3d10952..3ea08cc 100644
>> --- a/test/multi-pmem.c
>> +++ b/test/multi-pmem.c
>> @@ -249,7 +249,7 @@ int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx
>>  
>>  	ndctl_set_log_priority(ctx, loglevel);
>>  
>> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>>  	if (err < 0) {
>>  		result = 77;
>>  		ndctl_test_skip(test);
>> diff --git a/test/parent-uuid.c b/test/parent-uuid.c
>> index 6424e9f..bded33a 100644
>> --- a/test/parent-uuid.c
>> +++ b/test/parent-uuid.c
>> @@ -218,7 +218,7 @@ int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ct
>>  		return 77;
>>  
>>  	ndctl_set_log_priority(ctx, loglevel);
>> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>>  	if (err < 0) {
>>  		ndctl_test_skip(test);
>>  		fprintf(stderr, "nfit_test unavailable skipping tests\n");
>> diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
>> index f0f2edd..a4db1ae 100644
>> --- a/test/pmem_namespaces.c
>> +++ b/test/pmem_namespaces.c
>> @@ -191,7 +191,7 @@ int test_pmem_namespaces(int log_level, struct ndctl_test *test,
>>  
>>  	if (!bus) {
>>  		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
>> -		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
>> +		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
>>  		ndctl_invalidate(ctx);
>>  		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
>>  		if (rc < 0 || !bus) {
>> -- 
>> 2.30.2
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
