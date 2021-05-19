Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A17363887F7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 09:07:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D067100F2270;
	Wed, 19 May 2021 00:06:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6B64100F2251
	for <linux-nvdimm@lists.01.org>; Wed, 19 May 2021 00:06:55 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J74S80160340;
	Wed, 19 May 2021 03:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fBXR64mRS/oL4lgs3J4sJHfT03EYhYerJBpzWN58sXM=;
 b=JkhqtUinTHY18BsJLiJAUCOmA1bpdTYFJ097f+7GND4dY+dWgm+tGK3BiJK31Tj5Xlpe
 ORrN3WfhAd3fQaRiYoY8WoU+avtE7XAv7UbbpHrzL7tsDwEjL8rCyKv3Ue+cZakERi9Q
 7nOU2lqSVYc2Pl1PxHHbI3oI9Djc44MMvq2hZ1B2Q9FqPOdtAG0piD7GTok50eDTQScp
 xDiDKn6TRcsQEPG8wo/Bxd62aEVo+Ser/8dYcjWViVt48A2o1f3Vk4J4/CJZULZ+uE1g
 DPkZ+KSKuQt1bCATmFi7j29WaB+u9hZTJmZ7GuZW5jOiBpSVxh1pIElGiOntEwRXGpaV TQ==
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38mwxn84du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 May 2021 03:06:51 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14J6lDMC024897;
	Wed, 19 May 2021 07:06:50 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by ppma02wdc.us.ibm.com with ESMTP id 38jyu25k85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 May 2021 07:06:50 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14J76oiH39321890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 May 2021 07:06:50 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C88CAE068;
	Wed, 19 May 2021 07:06:50 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E40B9AE06F;
	Wed, 19 May 2021 07:06:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.42.71])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 19 May 2021 07:06:46 +0000 (GMT)
Subject: Re: [PATCH v3] powerpc/papr_scm: Reduce error severity if nvdimm
 stats inaccessible
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
References: <20210508043642.114076-1-vaibhav@linux.ibm.com>
From: kajoljain <kjain@linux.ibm.com>
Message-ID: <4daf4282-79c3-a115-0441-c56a563fa15b@linux.ibm.com>
Date: Wed, 19 May 2021 12:36:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210508043642.114076-1-vaibhav@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vv4tbiAqIpJJmpNmUDKHqRklj19zYurK
X-Proofpoint-GUID: vv4tbiAqIpJJmpNmUDKHqRklj19zYurK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_02:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105190050
Message-ID-Hash: JLBCLIWRUMASSAPUHWKF7QTXKXKR54HY
X-Message-ID-Hash: JLBCLIWRUMASSAPUHWKF7QTXKXKR54HY
X-MailFrom: kjain@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JLBCLIWRUMASSAPUHWKF7QTXKXKR54HY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/8/21 10:06 AM, Vaibhav Jain wrote:
> Currently drc_pmem_qeury_stats() generates a dev_err in case
> "Enable Performance Information Collection" feature is disabled from
> HMC or performance stats are not available for an nvdimm. The error is
> of the form below:
> 
> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
> 	 performance stats, Err:-10
> 
> This error message confuses users as it implies a possible problem
> with the nvdimm even though its due to a disabled/unavailable
> feature. We fix this by explicitly handling the H_AUTHORITY and
> H_UNSUPPORTED errors from the H_SCM_PERFORMANCE_STATS hcall.
> 
> In case of H_AUTHORITY error an info message is logged instead of an
> error, saying that "Permission denied while accessing performance
> stats" and an EPERM error is returned back.
> 
> In case of H_UNSUPPORTED error we return a EOPNOTSUPP error back from
> drc_pmem_query_stats() indicating that performance stats-query
> operation is not supported on this nvdimm.
> 
> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog
> 
> v3:
> * Return EOPNOTSUPP error in case of H_UNSUPPORTED [ Ira ]
> * Return EPERM in case of H_AUTHORITY [ Ira ]
> * Updated patch description
> 

Patch looks good to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> v2:
> * Updated the message logged in case of H_AUTHORITY error [ Ira ]
> * Switched from dev_warn to dev_info in case of H_AUTHORITY error.
> * Instead of -EPERM return -EACCESS for H_AUTHORITY error.
> * Added explicit handling of H_UNSUPPORTED error.
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index ef26fe40efb0..e2b69cc3beaf 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -310,6 +310,13 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>  		dev_err(&p->pdev->dev,
>  			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
>  		return -ENOENT;
> +	} else if (rc == H_AUTHORITY) {
> +		dev_info(&p->pdev->dev,
> +			 "Permission denied while accessing performance stats");
> +		return -EPERM;
> +	} else if (rc == H_UNSUPPORTED) {
> +		dev_dbg(&p->pdev->dev, "Performance stats unsupported\n");
> +		return -EOPNOTSUPP;
>  	} else if (rc != H_SUCCESS) {
>  		dev_err(&p->pdev->dev,
>  			"Failed to query performance stats, Err:%lld\n", rc);
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
