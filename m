Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A22154BF
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Jul 2020 11:29:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63B2411068191;
	Mon,  6 Jul 2020 02:29:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harish@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4EAC1106818F
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 02:29:53 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06693NiL153688;
	Mon, 6 Jul 2020 05:29:51 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 322ndv48rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2020 05:29:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0669GsTD010034;
	Mon, 6 Jul 2020 09:29:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03fra.de.ibm.com with ESMTP id 322hd7s2u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2020 09:29:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0669Tj1P51314688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2020 09:29:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB681A405F;
	Mon,  6 Jul 2020 09:29:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21141A405B;
	Mon,  6 Jul 2020 09:29:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.1.42])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2020 09:29:43 +0000 (GMT)
Subject: Re: [PATCH ndctl] namespace-action: Don't act on any seed namespaces
To: Santosh Sivaraj <santosh@fossix.org>, linux-nvdimm@lists.01.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20200705041519.3263863-1-santosh@fossix.org>
From: Harish <harish@linux.ibm.com>
Message-ID: <b79f5d0d-d0ef-09a3-5f19-456512941e6c@linux.ibm.com>
Date: Mon, 6 Jul 2020 14:59:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705041519.3263863-1-santosh@fossix.org>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_04:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 cotscore=-2147483648 mlxlogscore=999 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060068
Message-ID-Hash: LBGKZM4ITF335DRPFSBFUCINLORP5RVZ
X-Message-ID-Hash: LBGKZM4ITF335DRPFSBFUCINLORP5RVZ
X-MailFrom: harish@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LBGKZM4ITF335DRPFSBFUCINLORP5RVZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Tested-by: Harish <harish@linux.ibm.com>

- Harish

On 7/5/20 9:45 AM, Santosh Sivaraj wrote:
> Catch seed namespaces early on. This will prevent checking for sizes in enable,
> disable and destroy namespace code path, which in turn prevents the inconsistent
> reporting in count of enabled/disabled namespaces.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>   ndctl/lib/libndctl.c |  5 -----
>   ndctl/namespace.c    | 14 ++------------
>   2 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index ee737cb..d0599f7 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -4130,16 +4130,11 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
>   	const char *devname = ndctl_namespace_get_devname(ndns);
>   	struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
>   	struct ndctl_region *region = ndns->region;
> -	unsigned long long size = ndctl_namespace_get_size(ndns);
>   	int rc;
>   
>   	if (ndctl_namespace_is_enabled(ndns))
>   		return 0;
>   
> -	/* Don't try to enable idle namespace (no capacity allocated) */
> -	if (size == 0)
> -		return -ENXIO;
> -
>   	rc = ndctl_bind(ctx, ndns->module, devname);
>   
>   	/*
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 0550580..5a086d0 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -1102,7 +1102,6 @@ static int namespace_destroy(struct ndctl_region *region,
>   		struct ndctl_namespace *ndns)
>   {
>   	const char *devname = ndctl_namespace_get_devname(ndns);
> -	unsigned long long size;
>   	bool did_zero = false;
>   	int rc;
>   
> @@ -1147,19 +1146,9 @@ static int namespace_destroy(struct ndctl_region *region,
>   		goto out;
>   	}
>   
> -	size = ndctl_namespace_get_size(ndns);
> -
>   	rc = ndctl_namespace_delete(ndns);
>   	if (rc)
>   		debug("%s: failed to reclaim\n", devname);
> -
> -	/*
> -	 * Don't report a destroyed namespace when no capacity was
> -	 * allocated.
> -	 */
> -	if (size == 0 && rc == 0)
> -		rc = 1;
> -
>   out:
>   	return rc;
>   }
> @@ -2128,8 +2117,9 @@ static int do_xaction_namespace(const char *namespace,
>   			ndctl_namespace_foreach_safe(region, ndns, _n) {
>   				ndns_name = ndctl_namespace_get_devname(ndns);
>   
> -				if (strcmp(namespace, "all") != 0
> +				if ((strcmp(namespace, "all") != 0
>   						&& strcmp(namespace, ndns_name) != 0)
> +				    || ndctl_namespace_get_size(ndns) == 0)
>   					continue;
>   				switch (action) {
>   				case ACTION_DISABLE:
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
