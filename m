Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D02D1BD699
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Apr 2020 09:52:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C202100675E5;
	Wed, 29 Apr 2020 00:51:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3AB88100675E4
	for <linux-nvdimm@lists.01.org>; Wed, 29 Apr 2020 00:51:20 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T7WwCE069783;
	Wed, 29 Apr 2020 03:52:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30mh6vbssu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2020 03:52:16 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03T7WwYb069772;
	Wed, 29 Apr 2020 03:52:15 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30mh6vbss6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2020 03:52:15 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T7ocAi022747;
	Wed, 29 Apr 2020 07:52:15 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by ppma02dal.us.ibm.com with ESMTP id 30mcu6utmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2020 07:52:15 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T7qEVl54329764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2020 07:52:14 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 614A8112061;
	Wed, 29 Apr 2020 07:52:14 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDF99112062;
	Wed, 29 Apr 2020 07:52:11 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.44.76])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2020 07:52:11 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH v2 1/6] libndctl: Refactor out add_dimm() to
 handle NFIT specific init
In-Reply-To: <20200420075556.272174-2-vaibhav@linux.ibm.com>
References: <20200420075556.272174-1-vaibhav@linux.ibm.com>
 <20200420075556.272174-2-vaibhav@linux.ibm.com>
Date: Wed, 29 Apr 2020 13:22:09 +0530
Message-ID: <87ftcm20gm.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_02:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=2 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290057
Message-ID-Hash: AP7EXOGCZS732WFTVOHP6EFWT7IXEJWX
X-Message-ID-Hash: AP7EXOGCZS732WFTVOHP6EFWT7IXEJWX
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AP7EXOGCZS732WFTVOHP6EFWT7IXEJWX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Presently add_dimm() only probes dimms that support NFIT/ACPI. Hence
> this patch refactors this functionality into two functions namely
> add_dimm() and add_nfit_dimm(). Function add_dimm() performs
> allocation and common 'struct ndctl_dimm' initialization and depending
> on whether the dimm-bus supports NIFT, calls add_nfit_dimm(). Once
> the probe is completed based on the value of 'ndctl_dimm.cmd_family'
> appropriate dimm-ops are assigned to the dimm.
>
> In case dimm-bus is of unknown type or doesn't support NFIT the
> initialization still continues, with no dimm-ops assigned to the
> 'struct ndctl_dimm' there-by limiting the functionality available.
>
> This patch shouldn't introduce any behavioral change.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> v1..v2:
> * None
> ---
>  ndctl/lib/libndctl.c | 193 +++++++++++++++++++++++++------------------
>  1 file changed, 112 insertions(+), 81 deletions(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index ee737cbbfe3e..d76dbf7e17de 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -1441,82 +1441,15 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
>  static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
>  static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
>  
> -static void *add_dimm(void *parent, int id, const char *dimm_base)
> +static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>  {
> -	int formats, i;
> -	struct ndctl_dimm *dimm;
> +	int i, rc = -1;
>  	char buf[SYSFS_ATTR_SIZE];
> -	struct ndctl_bus *bus = parent;
> -	struct ndctl_ctx *ctx = bus->ctx;
> +	struct ndctl_ctx *ctx = dimm->bus->ctx;
>  	char *path = calloc(1, strlen(dimm_base) + 100);
>  
>  	if (!path)
> -		return NULL;
> -
> -	sprintf(path, "%s/nfit/formats", dimm_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		formats = 1;
> -	else

....
> +	rc = 0;
> + err_read:
> +
> +	free(path);
> +	return rc;
> +}
> +
> +static void *add_dimm(void *parent, int id, const char *dimm_base)
> +{
> +	int formats, i, rc = -ENODEV;
> +	struct ndctl_dimm *dimm = NULL;
> +	char buf[SYSFS_ATTR_SIZE];
> +	struct ndctl_bus *bus = parent;
> +	struct ndctl_ctx *ctx = bus->ctx;
> +	char *path = calloc(1, strlen(dimm_base) + 100);
> +
> +	if (!path)
> +		return NULL;
> +
> +	sprintf(path, "%s/nfit/formats", dimm_base);

Witht that abstraction this should be part of add_nfit_dimm?

> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		formats = 1;
> +	else
> +		formats = clamp(strtoul(buf, NULL, 0), 1UL, 2UL);
> +
> +	dimm = calloc(1, sizeof(*dimm) + sizeof(int) * formats);
> +	if (!dimm)
> +		goto err_dimm;
> +	dimm->bus = bus;
> +	dimm->id = id;
> +
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
