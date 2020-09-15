Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790726A948
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 18:03:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7852214004CB4;
	Tue, 15 Sep 2020 09:03:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2499613FB28A8
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 09:03:52 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FG1SIm119032;
	Tue, 15 Sep 2020 12:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=SwR/NUKjqj9dDzt+IBXdDhZdkVJA83w5Z/hX3YGGBtg=;
 b=bNX9tn2dIB06r/QNkD5Z9DLDAagvsRbcmLjoJfX0CzPGwULtLI9ElgZMox9XII3f9J92
 WPfHApxMgXnOcgSpxJmPC15ZJD2twQDseo/O3oP3K7AO0ZT57Msk1/tXrfKXAqEH7pOE
 xclHhdydaLG+Z6lonLx9NH+HEXkymdf18IC05+kZsz61nzCHVZIXlh5yYdSfUBT7FQHh
 8R64Q6e+OynWC4/UQLxyH/s8gi72wsLrZZq5RGfNhpv4/YcSIjg9yBZi/W4Dy6tLEtcE
 +Boik+/aDj//fbi71B5fPMcY5U1m3YSbgcZwheZOYq6AvBISvykvBH+3onESOGSwKvme 3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33k0ah0rkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2020 12:03:44 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FG1oRB120083;
	Tue, 15 Sep 2020 12:03:44 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33k0ah0rhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2020 12:03:43 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FG2xdo008654;
	Tue, 15 Sep 2020 16:03:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma04fra.de.ibm.com with ESMTP id 33guvm1tad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2020 16:03:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FG3dma16253300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2020 16:03:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33DDD42041;
	Tue, 15 Sep 2020 16:03:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E66434203F;
	Tue, 15 Sep 2020 16:03:35 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.46.1])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 15 Sep 2020 16:03:35 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 21:33:34 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] powerpc/papr_scm: Fix warning triggered by
 perf_stats_show()
In-Reply-To: <87imcfp9a7.fsf@mpe.ellerman.id.au>
References: <20200912081451.66225-1-vaibhav@linux.ibm.com>
 <87imcfp9a7.fsf@mpe.ellerman.id.au>
Date: Tue, 15 Sep 2020 21:33:34 +0530
Message-ID: <87mu1rdo2x.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=1 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150128
Message-ID-Hash: OQJ2L4FTEA7ZJVGC73KU7ABOPA4MYYMU
X-Message-ID-Hash: OQJ2L4FTEA7ZJVGC73KU7ABOPA4MYYMU
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OQJ2L4FTEA7ZJVGC73KU7ABOPA4MYYMU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Michael Ellerman <mpe@ellerman.id.au> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>> A warning is reported by the kernel in case perf_stats_show() returns
>> an error code. The warning is of the form below:
>>
>>  papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
>>  	  Failed to query performance stats, Err:-10
>>  dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
>>  fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count
>>
>> On investigation it looks like that the compiler is silently truncating the
>> return value of drc_pmem_query_stats() from 'long' to 'int', since the
>> variable used to store the return code 'rc' is an 'int'. This
>> truncated value is then returned back as a 'ssize_t' back from
>> perf_stats_show() to 'dev_attr_show()' which thinks of it as a large
>> unsigned number and triggers this warning..
>>
>> To fix this we update the type of variable 'rc' from 'int' to
>> 'ssize_t' that prevents the compiler from truncating the return value
>> of drc_pmem_query_stats() and returning correct signed value back from
>> perf_stats_show().
>>
>> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance
>>        stats from PHYP')
>
> Please don't word wrap the Fixes tag it breaks b4.
>
> I've fixed it up this time.

Thanks Mpe

>
> cheers

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
