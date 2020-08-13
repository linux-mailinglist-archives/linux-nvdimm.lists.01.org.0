Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0F2439D1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Aug 2020 14:32:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8AD061305A24F;
	Thu, 13 Aug 2020 05:32:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 19E301305A24C
	for <linux-nvdimm@lists.01.org>; Thu, 13 Aug 2020 05:32:14 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DCW5cZ133246;
	Thu, 13 Aug 2020 08:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kxzfLQJWxdRsd8mjmj8kZfBAm6a6C/k6V/J+4dOsO38=;
 b=jqqt7GrWLeEvaGsabpGimj06CZzwFxHGeClheV3a2eRCKkysEX/Vqcu5rLhlHsJMzNpK
 rnyqlIBxdljPGJyWeWke/8FlEd30vSC1aXEOdYOu1et0wgIN49PDoXO0emfXpNzGI/sh
 yUSdBaWB8K2To9GZq9h9N2t7D95g5vyeZWlGjvq1PUNFJtlZSCUjB1QPADNZOFneGrTc
 FR1TorWrANtJg5aen+tCI+Kp9vfLzKyyNJd3kc5F6xdEncZxpBZCefni0/PSIUd7eLEu
 vpsvjXL88Gh90kgDMRN2cpcGn8JBSs3sEmlnkh/Ruw7wj9LBFNWVryZqF2XUXQGYQndU jQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32vbd0pnvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2020 08:32:06 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DCW5HD133290;
	Thu, 13 Aug 2020 08:32:05 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32vbd0pnp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2020 08:32:05 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DCLWB2018227;
	Thu, 13 Aug 2020 12:31:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma06ams.nl.ibm.com with ESMTP id 32skahdhw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2020 12:31:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DCU96K50987336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2020 12:30:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37A5542045;
	Thu, 13 Aug 2020 12:31:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DF8342042;
	Thu, 13 Aug 2020 12:31:35 +0000 (GMT)
Received: from [9.79.219.81] (unknown [9.79.219.81])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2020 12:31:35 +0000 (GMT)
Subject: Re: [PATCH] powerpc/papr_scm: Limit the readability of 'perf_stats'
 sysfs attribute
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
References: <20200813043458.165718-1-vaibhav@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <13e82e40-35c7-266c-2ec0-5fcdcb5fb27f@linux.ibm.com>
Date: Thu, 13 Aug 2020 18:01:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813043458.165718-1-vaibhav@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_10:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130092
Message-ID-Hash: 36EXT6JYGLJ4GMZDPVMFYNCKTTZKJH4E
X-Message-ID-Hash: 36EXT6JYGLJ4GMZDPVMFYNCKTTZKJH4E
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/36EXT6JYGLJ4GMZDPVMFYNCKTTZKJH4E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 8/13/20 10:04 AM, Vaibhav Jain wrote:
> The newly introduced 'perf_stats' attribute uses the default access
> mode of 0444 letting non-root users access performance stats of an
> nvdimm and potentially force the kernel into issuing large number of
> expensive HCALLs. Since the information exposed by this attribute
> cannot be cached hence its better to ward of access to this attribute
> from users who don't need to access these performance statistics.
> 
> Hence this patch adds check in perf_stats_show() to only let users
> that are 'perfmon_capable()' to read the nvdimm performance
> statistics.
> 
> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/papr_scm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index f439f0dfea7d1..36c51bf8af9a8 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -792,6 +792,10 @@ static ssize_t perf_stats_show(struct device *dev,
>   	struct nvdimm *dimm = to_nvdimm(dev);
>   	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
>   
> +	/* Allow access only to perfmon capable users */
> +	if (!perfmon_capable())
> +		return -EACCES;
> +

An access check is usually done in open(). This is the read callback IIUC.

>   	if (!p->stat_buffer_len)
>   		return -ENOENT;
>   
> 

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
