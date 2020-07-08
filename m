Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10495217F7E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 08:22:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF950110BC281;
	Tue,  7 Jul 2020 23:22:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=harish@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C72C110BA96D
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 23:22:35 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06860e4o117459;
	Wed, 8 Jul 2020 02:22:11 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0b-001b2d01.pphosted.com with ESMTP id 3256x52pja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 02:22:11 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0686G93g017603;
	Wed, 8 Jul 2020 06:22:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma02fra.de.ibm.com with ESMTP id 322hd84a3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 06:22:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0686M7ab59637972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 06:22:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44125204E;
	Wed,  8 Jul 2020 06:22:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.68.220])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7F12B52050;
	Wed,  8 Jul 2020 06:22:06 +0000 (GMT)
Subject: Re: [ndctl PATCH] infoblock: Make output mutually exclusive
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Cc: santosh@fossix.org, ira.weiny@intel.com
References: <20200707164635.31217-1-harish@linux.ibm.com>
From: Harish <harish@linux.ibm.com>
Message-ID: <bd4f4a33-383a-bdc9-b4fa-15cf07199234@linux.ibm.com>
Date: Wed, 8 Jul 2020 11:52:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707164635.31217-1-harish@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_01:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 cotscore=-2147483648
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080038
Message-ID-Hash: LA2U64GNPAN77DQ74TIJUYIDJS6RCOHT
X-Message-ID-Hash: LA2U64GNPAN77DQ74TIJUYIDJS6RCOHT
X-MailFrom: harish@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LA2U64GNPAN77DQ74TIJUYIDJS6RCOHT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

This patch can be dropped as the error specifies namespace filter also 
is mutually exclusive
with these options, so this is not needed. The usage confused me as it 
portrays namespace
filtering to be mandatory as opposed to the Documentation.

Command line:
usage: ndctl write-infoblock <namespace> [<options>]

Sorry for the noise.

- Harish

On 7/7/20 10:16 PM, Harish wrote:
> Patch fixes checking output filter option (-o <file> or -c) of
> write-infoblock command to be mutually exclusive.
>
> Signed-off-by: Harish <harish@linux.ibm.com>
> ---
>   ndctl/namespace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 0550580..d3ade25 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -440,7 +440,7 @@ static const char *parse_namespace_options(int argc, const char **argv,
>   		rc = -EINVAL;
>   	}
>   
> -	if (action == ACTION_WRITE_INFOBLOCK && (param.outfile || param.std_out)
> +	if (action == ACTION_WRITE_INFOBLOCK && (param.outfile && param.std_out)
>   			&& argc) {
>   		error("specify only one of a namespace filter, --output, or --stdout\n");
>   		rc = -EINVAL;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
