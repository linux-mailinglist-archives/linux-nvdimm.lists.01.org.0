Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669D43764FB
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 14:18:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B85C0100EAB6F;
	Fri,  7 May 2021 05:18:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 67FA5100EAB6B
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 05:18:53 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147C4HNa145163;
	Fri, 7 May 2021 08:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=J47BGLLd8vxfyQEKsvcgegBLj2p88069X4f1aWKgUCk=;
 b=m9ZRgFZdCA/QRo+jHfAJIQ7mAEK9SjGHUTjenFX6VlsWd6PT7g7MOUNc8I7I/4OaDjAH
 p53bC8ij4nhsX+nUdY6oHK7l8w4hEv8hwcQblijOAE4JLIKKsMmIccUPw264uOkSQQ1a
 ULpEemJoFV1Zd8wzPMBrIrYWHjDXGCp9DiY112jvQ00HYZl4UvqfQp8P/H15/vsz0eCy
 LZ9omuSYBRNd4qLftTAM5dROye6/CrKvAMeHP56aG9qNrqNaLMsKK3IsKxisv5qaiSDQ
 JRudN2DCn+UbtLXD8JlZ8qLpuBYygxCFMntXgee3r83AWVw7k1EEDSyaAw8XNaaXMGHp vg==
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38d42mt6xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 May 2021 08:18:47 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 147CCRAL028865;
	Fri, 7 May 2021 12:18:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma01fra.de.ibm.com with ESMTP id 38csqgr5bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 May 2021 12:18:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 147CIgsj33554736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 May 2021 12:18:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA7A942042;
	Fri,  7 May 2021 12:18:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99CDE4203F;
	Fri,  7 May 2021 12:18:40 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.69.191])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri,  7 May 2021 12:18:40 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 07 May 2021 17:48:39 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Reduce error severity if nvdimm
 stats inaccessible
In-Reply-To: <20210506045817.GF1068722@iweiny-DESK2.sc.intel.com>
References: <20210505191606.51666-1-vaibhav@linux.ibm.com>
 <20210506045817.GF1068722@iweiny-DESK2.sc.intel.com>
Date: Fri, 07 May 2021 17:48:39 +0530
Message-ID: <87eeeiu480.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r78fIpOtfLI4KlpJAc7O7KZeB7IU-5dw
X-Proofpoint-GUID: r78fIpOtfLI4KlpJAc7O7KZeB7IU-5dw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070083
Message-ID-Hash: FS7QNWNHJ32WF3V7BUDRFM2D3SQLLJFA
X-Message-ID-Hash: FS7QNWNHJ32WF3V7BUDRFM2D3SQLLJFA
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V  <aneesh.kumar@linux.ibm.com>, Michael Ellerman" <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FS7QNWNHJ32WF3V7BUDRFM2D3SQLLJFA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ira,

Thanks for looking into this patch

Ira Weiny <ira.weiny@intel.com> writes:

> On Thu, May 06, 2021 at 12:46:06AM +0530, Vaibhav Jain wrote:
>> Currently drc_pmem_qeury_stats() generates a dev_err in case
>> "Enable Performance Information Collection" feature is disabled from
>> HMC or performance stats are not available for an nvdimm. The error is
>> of the form below:
>> 
>> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
>> 	 performance stats, Err:-10
>> 
>> This error message confuses users as it implies a possible problem
>> with the nvdimm even though its due to a disabled/unavailable
>> feature. We fix this by explicitly handling the H_AUTHORITY and
>> H_UNSUPPORTED errors from the H_SCM_PERFORMANCE_STATS hcall.
>> 
>> In case of H_AUTHORITY error an info message is logged instead of an
>> error, saying that "Permission denied while accessing performance
>> stats". Also '-EACCES' error is return instead of -EPERM.
>
> I thought you clarified before that this was a permission issue.  So why change
> the error to EACCES?
>
EACCESS("Permission Denied") felt like a more accurate error code for
this case than EPERM("Operation not permitted"). So switched the usage
of EPERM error code to handle the case if this hcall is not supported
for an nvdimm.

>> 
>> In case of H_UNSUPPORTED error we return a -EPERM error back from
>> drc_pmem_query_stats() indicating that performance stats-query
>> operation is not supported on this nvdimm.
>
> EPERM seems wrong here too...  ENOTSUP?
Yes, will change it to EOPNOTSUPP in v3.

>
> Ira
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
