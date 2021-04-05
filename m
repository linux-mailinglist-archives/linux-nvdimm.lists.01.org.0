Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D315354204
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Apr 2021 14:25:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95832100EBB71;
	Mon,  5 Apr 2021 05:25:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4B646100EBB6A
	for <linux-nvdimm@lists.01.org>; Mon,  5 Apr 2021 05:25:42 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 135C45EZ019549;
	Mon, 5 Apr 2021 08:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=rHm/dLhW2vsv/dUS6CuFKF+wkNGSlliB7NFt/Wc12Pw=;
 b=JeqopDKJhs+2/cHWkzA/fxuYbrS6NDiiXVPG0sNl4QPXgvp17b5ZvZZkOGKZLEywijQT
 ziXV62VQyFCW3LtWCDrY5LsZ0iH8YZDfqjW7t6N+K2/KANfog8S4imdPUYHw0/TjWgPb
 /kwTmYw16tl7tPGCiwUXOcmd/m6vifXUPbPg31tubu/bBenUMULpGSVbNnDcuiD+YJK3
 kW97VBWQ15+uS9IKfivrJw2W5BYIPKbE/kIH0gpsQ+tX7VA9qcmMA1aqq7QfW+pSZhbB
 ecUaAzvnINkd5YsLTyYaOUvAbjHvQiJ32PNl6t4bDJBMvaopnjbPeo5xIX9smC8jG9el Jg==
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37q5ea1aua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Apr 2021 08:25:39 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 135CDe0i014911;
	Mon, 5 Apr 2021 12:25:38 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma04dal.us.ibm.com with ESMTP id 37q2n62r6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Apr 2021 12:25:38 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 135CPaw420578754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Apr 2021 12:25:37 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA2846A04D;
	Mon,  5 Apr 2021 12:25:36 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EBF26A047;
	Mon,  5 Apr 2021 12:25:34 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.75.170])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon,  5 Apr 2021 12:25:33 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Santosh Sivaraj <santosh@fossix.org>,
        Linux NVDIMM <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH 2/4] test: Don't skip tests if nfit modules are missing
In-Reply-To: <20210328021001.2340251-2-santosh@fossix.org>
References: <20210328021001.2340251-1-santosh@fossix.org>
 <20210328021001.2340251-2-santosh@fossix.org>
Date: Mon, 05 Apr 2021 17:55:31 +0530
Message-ID: <877dlg7was.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qg_RrwCCkA78iW6P9Nzr5zj-eqAOxeHp
X-Proofpoint-ORIG-GUID: qg_RrwCCkA78iW6P9Nzr5zj-eqAOxeHp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_08:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050083
Message-ID-Hash: LWZWRIL3P5GOHMLPOGZAIPAA52O3UF7S
X-Message-ID-Hash: LWZWRIL3P5GOHMLPOGZAIPAA52O3UF7S
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LWZWRIL3P5GOHMLPOGZAIPAA52O3UF7S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Santosh Sivaraj <santosh@fossix.org> writes:

> For NFIT to be available ACPI is a must, so don't fail when nfit modules
> are missing on a platform that doesn't support ACPI.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  test.h                        |  2 +-
>  test/ack-shutdown-count-set.c |  2 +-
>  test/blk_namespaces.c         |  2 +-
>  test/core.c                   | 30 ++++++++++++++++++++++++++++--
>  test/dpa-alloc.c              |  2 +-
>  test/dsm-fail.c               |  2 +-
>  test/libndctl.c               |  2 +-
>  test/multi-pmem.c             |  2 +-
>  test/parent-uuid.c            |  2 +-
>  test/pmem_namespaces.c        |  2 +-
>  10 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/test.h b/test.h
> index cba8d41..7de13fe 100644
> --- a/test.h
> +++ b/test.h
> @@ -20,7 +20,7 @@ void builtin_xaction_namespace_reset(void);
>  
>  struct kmod_ctx;
>  struct kmod_module;
> -int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
> +int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>  		struct ndctl_ctx *nd_ctx, int log_level,
>  		struct ndctl_test *test);
>  
> diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
> index fb1d82b..c561ff3 100644
> --- a/test/ack-shutdown-count-set.c
> +++ b/test/ack-shutdown-count-set.c
> @@ -99,7 +99,7 @@ static int test_ack_shutdown_count_set(int loglevel, struct ndctl_test *test,
>  	int result = EXIT_FAILURE, err;
>  
>  	ndctl_set_log_priority(ctx, loglevel);
> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>  	if (err < 0) {
>  		result = 77;
>  		ndctl_test_skip(test);
> diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
> index d7f00cb..f076e85 100644
> --- a/test/blk_namespaces.c
> +++ b/test/blk_namespaces.c
> @@ -228,7 +228,7 @@ int test_blk_namespaces(int log_level, struct ndctl_test *test,
>  
>  	if (!bus) {
>  		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
> -		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
> +		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
>  		ndctl_invalidate(ctx);
>  		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
>  		if (rc < 0 || !bus) {
> diff --git a/test/core.c b/test/core.c
> index cc7d8d9..44cb277 100644
> --- a/test/core.c
> +++ b/test/core.c
> @@ -11,6 +11,7 @@
>  #include <util/log.h>
>  #include <util/sysfs.h>
>  #include <ndctl/libndctl.h>
> +#include <ndctl/ndctl.h>
>  #include <ccan/array_size/array_size.h>
>  
>  #define KVER_STRLEN 20
> @@ -106,11 +107,11 @@ int ndctl_test_get_skipped(struct ndctl_test *test)
>  	return test->skip;
>  }
>  
> -int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
> +int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>  		struct ndctl_ctx *nd_ctx, int log_level,
>  		struct ndctl_test *test)
>  {
> -	int rc;
> +	int rc, family = -1;
>  	unsigned int i;
>  	const char *name;
>  	struct ndctl_bus *bus;
> @@ -127,10 +128,30 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>  		"nd_e820",
>  		"nd_pmem",
>  	};
> +	char *test_env;
>  
>  	log_init(&log_ctx, "test/init", "NDCTL_TEST");
>  	log_ctx.log_priority = log_level;
>  
> +	/*
> +	 * The following two checks determine the platform family. For
> +	 * Intel/platforms which support ACPI, check sysfs; for other platforms
> +	 * determine from the environment variable NVDIMM_TEST_FAMILY
> +	 */
> +	if (access("/sys/bus/acpi", F_OK) == 0) {
> +		if (errno == ENOENT)
> +			family = NVDIMM_FAMILY_INTEL;
> +	}
> +
> +	test_env = getenv("NDCTL_TEST_FAMILY");
> +	if (test_env && strcmp(test_env, "PAPR") == 0)
> +		family = NVDIMM_FAMILY_PAPR;

I am wondering whether it is confusing to call this as
NVDIMM_FAMILY_PAPR. If you are looking at a platform agnoistic family we
should probably name it accordingly. Maybe NVDIMM_FAMILY_TEST ?


> +
> +	if (family == -1) {
> +		log_err(&log_ctx, "Cannot determine NVDIMM family\n");
> +		return -ENOTSUP;
> +	}
> +
>  	*ctx = kmod_new(NULL, NULL);
>  	if (!*ctx)
>  		return -ENXIO;
> @@ -185,6 +206,11 @@ retry:
>  
>  		path = kmod_module_get_path(*mod);
>  		if (!path) {
> +			if (family != NVDIMM_FAMILY_INTEL &&
> +			    (strcmp(name, "nfit") == 0 ||
> +			     strcmp(name, "nd_e820") == 0))
> +				continue;
> +
>  			log_err(&log_ctx, "%s.ko: failed to get path\n", name);
>  			break;
>  		}
> diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
> index e922009..0b3bb7a 100644
> --- a/test/dpa-alloc.c
> +++ b/test/dpa-alloc.c
> @@ -289,7 +289,7 @@ int test_dpa_alloc(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
>  		return 77;
>  
>  	ndctl_set_log_priority(ctx, loglevel);
> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>  	if (err < 0) {
>  		ndctl_test_skip(test);
>  		fprintf(stderr, "nfit_test unavailable skipping tests\n");
> diff --git a/test/dsm-fail.c b/test/dsm-fail.c
> index 9dfd8b0..0a6383d 100644
> --- a/test/dsm-fail.c
> +++ b/test/dsm-fail.c
> @@ -346,7 +346,7 @@ int test_dsm_fail(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
>  	int result = EXIT_FAILURE, err;
>  
>  	ndctl_set_log_priority(ctx, loglevel);
> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>  	if (err < 0) {
>  		result = 77;
>  		ndctl_test_skip(test);
> diff --git a/test/libndctl.c b/test/libndctl.c
> index 24d72b3..0e88fce 100644
> --- a/test/libndctl.c
> +++ b/test/libndctl.c
> @@ -2692,7 +2692,7 @@ int test_libndctl(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx)
>  	daxctl_set_log_priority(daxctl_ctx, loglevel);
>  	ndctl_set_private_data(ctx, test);
>  
> -	err = nfit_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
> +	err = ndctl_test_init(&kmod_ctx, &mod, ctx, loglevel, test);
>  	if (err < 0) {
>  		ndctl_test_skip(test);
>  		fprintf(stderr, "nfit_test unavailable skipping tests\n");
> diff --git a/test/multi-pmem.c b/test/multi-pmem.c
> index 3d10952..3ea08cc 100644
> --- a/test/multi-pmem.c
> +++ b/test/multi-pmem.c
> @@ -249,7 +249,7 @@ int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx
>  
>  	ndctl_set_log_priority(ctx, loglevel);
>  
> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>  	if (err < 0) {
>  		result = 77;
>  		ndctl_test_skip(test);
> diff --git a/test/parent-uuid.c b/test/parent-uuid.c
> index 6424e9f..bded33a 100644
> --- a/test/parent-uuid.c
> +++ b/test/parent-uuid.c
> @@ -218,7 +218,7 @@ int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ct
>  		return 77;
>  
>  	ndctl_set_log_priority(ctx, loglevel);
> -	err = nfit_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
> +	err = ndctl_test_init(&kmod_ctx, &mod, NULL, loglevel, test);
>  	if (err < 0) {
>  		ndctl_test_skip(test);
>  		fprintf(stderr, "nfit_test unavailable skipping tests\n");
> diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
> index f0f2edd..a4db1ae 100644
> --- a/test/pmem_namespaces.c
> +++ b/test/pmem_namespaces.c
> @@ -191,7 +191,7 @@ int test_pmem_namespaces(int log_level, struct ndctl_test *test,
>  
>  	if (!bus) {
>  		fprintf(stderr, "ACPI.NFIT unavailable falling back to nfit_test\n");
> -		rc = nfit_test_init(&kmod_ctx, &mod, NULL, log_level, test);
> +		rc = ndctl_test_init(&kmod_ctx, &mod, NULL, log_level, test);
>  		ndctl_invalidate(ctx);
>  		bus = ndctl_bus_get_by_provider(ctx, "nfit_test.0");
>  		if (rc < 0 || !bus) {
> -- 
> 2.30.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
