Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A419F4E6
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Apr 2020 13:41:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C05E10FD2ADC;
	Mon,  6 Apr 2020 04:42:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=harish@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC60C10FD2ADA
	for <linux-nvdimm@lists.01.org>; Mon,  6 Apr 2020 04:42:34 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036BXvZN096018
	for <linux-nvdimm@lists.01.org>; Mon, 6 Apr 2020 07:41:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 3082cgtr3k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 06 Apr 2020 07:41:44 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <harish@linux.ibm.com>;
	Mon, 6 Apr 2020 12:41:25 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 6 Apr 2020 12:41:22 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 036BfcmD37552496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2020 11:41:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A908811C052;
	Mon,  6 Apr 2020 11:41:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C48A511C050;
	Mon,  6 Apr 2020 11:41:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.108.222])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2020 11:41:37 +0000 (GMT)
Subject: Re: [PATCH] ndctl/namespace: skip zero namespaces when processing
To: Michal Suchanek <msuchanek@suse.de>, linux-nvdimm@lists.01.org
References: <20200403210514.21786-1-msuchanek@suse.de>
From: Harish <harish@linux.ibm.com>
Date: Mon, 6 Apr 2020 17:11:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403210514.21786-1-msuchanek@suse.de>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20040611-0008-0000-0000-0000036B783E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040611-0009-0000-0000-00004A8D0E37
Message-Id: <1fda4cb0-3ca7-3701-a2ad-fc99cec0432d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_07:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060097
Message-ID-Hash: R72WG6TKYOHUBW6TYBRWFKNK7E2QERUM
X-Message-ID-Hash: R72WG6TKYOHUBW6TYBRWFKNK7E2QERUM
X-MailFrom: harish@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: jack@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R72WG6TKYOHUBW6TYBRWFKNK7E2QERUM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Tested-by: Harish Sriram <harish@linux.ibm.com>


On 4/4/20 2:35 AM, Michal Suchanek wrote:
> Hello,
>
> this is a fix for github issue #41. I tested on system with vpmem with
> ndctl 64.1 that the issue is fixed. master builds with the fix applied.
>
> 8<-------------------------------------------------------------------->8
>
> The kernel always creates zero length namespace with uuid 0 in each
> region.
>
> When processing all namespaces the user gets confusing errors from ndctl
> trying to process this namespace. Skip it.
>
> The user can still specify the namespace by name directly in case
> processing it is desirable.
>
> Fixes: #41
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>   ndctl/namespace.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 0550580707e8..6f4a4b5b8883 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -2128,9 +2128,19 @@ static int do_xaction_namespace(const char *namespace,
>   			ndctl_namespace_foreach_safe(region, ndns, _n) {
>   				ndns_name = ndctl_namespace_get_devname(ndns);
>
> -				if (strcmp(namespace, "all") != 0
> -						&& strcmp(namespace, ndns_name) != 0)
> -					continue;
> +				if (strcmp(namespace, "all") == 0) {
> +					static const uuid_t zero_uuid;
> +					uuid_t uuid;
> +
> +					ndctl_namespace_get_uuid(ndns, uuid);
> +					if (!ndctl_namespace_get_size(ndns) &&
> +					    !memcmp(uuid, zero_uuid, sizeof(uuid_t)))
> +						continue;
> +				} else {
> +					if (strcmp(namespace, ndns_name) != 0)
> +						continue;
> +				}
> +
>   				switch (action) {
>   				case ACTION_DISABLE:
>   					rc = ndctl_namespace_disable_safe(ndns);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
