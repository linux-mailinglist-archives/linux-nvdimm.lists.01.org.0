Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CEA137B5B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jan 2020 05:29:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA7EC10096C9B;
	Fri, 10 Jan 2020 20:32:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B5B7210096C97
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 20:32:30 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00B4RF2D019998
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 23:29:10 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xf73j898u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 23:29:10 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Sat, 11 Jan 2020 04:29:09 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Sat, 11 Jan 2020 04:29:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00B4T5kV24969540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Jan 2020 04:29:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A0BA405F;
	Sat, 11 Jan 2020 04:29:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FA81A4054;
	Sat, 11 Jan 2020 04:29:03 +0000 (GMT)
Received: from [9.85.72.79] (unknown [9.85.72.79])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Sat, 11 Jan 2020 04:29:03 +0000 (GMT)
Subject: Re: [PATCH v3 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
 <x49muavm4gx.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4inMqu=CbZo9KGFnHEhZowvcvXXWz67-opDjHATTbimJw@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Sat, 11 Jan 2020 09:59:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4inMqu=CbZo9KGFnHEhZowvcvXXWz67-opDjHATTbimJw@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20011104-0016-0000-0000-000002DC659B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011104-0017-0000-0000-0000333EEABF
Message-Id: <1ca0e78d-2c33-30cb-b3b0-f38eea4c7bf8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_04:2020-01-10,2020-01-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001110036
Message-ID-Hash: YSGLF42RJHPNA35LA66TMR3H6VWWSRCG
X-Message-ID-Hash: YSGLF42RJHPNA35LA66TMR3H6VWWSRCG
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YSGLF42RJHPNA35LA66TMR3H6VWWSRCG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 1/11/20 2:33 AM, Dan Williams wrote:
> On Fri, Jan 10, 2020 at 12:39 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Hi, Aneesh,
>>
>> After applying this patch series, several of my namespaces no longer
>> enumerate:
>>
>> Before:
>>
>> # ndctl list
>> [
>>    {
>>      "dev":"namespace0.2",
>>      "mode":"sector",
>>      "size":106541672960,
>>      "uuid":"ea1122b2-c219-424c-b09c-38a6e94a1042",
>>      "sector_size":512,
>>      "blockdev":"pmem0.2s"
>>    },
>>    {
>>      "dev":"namespace0.1",
>>      "mode":"fsdax",
>>      "map":"dev",
>>      "size":

>>      "uuid":"68b6746f-481a-4ae6-80b5-71d62176606c",
>>      "sector_size":512,
>>      "align":4096,
>>      "blockdev":"pmem0.1"
>>    },
>>    {
>>      "dev":"namespace0.0",
>>      "mode":"fsdax",
>>      "map":"dev",
>>      "size":52850327552,
>>      "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
>>      "sector_size":512,
>>      "align":2097152,
>>      "blockdev":"pmem0"
>>    }
>> ]
>>
>> After:
>>
>> # ndctl list
>> [
>>    {
>>      "dev":"namespace0.0",
>>      "mode":"fsdax",
>>      "map":"dev",
>>      "size":52850327552,
>>      "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
>>      "sector_size":512,
>>      "align":2097152,
>>      "blockdev":"pmem0"
>>    }
>> ]
>>
>> I won't have time to dig into it this week, but I wanted to mention it
>> before Dan merged these patches.
>>
>> I'll follow up next week with more information.
> 
> Thanks Jeff, I hadn't had a chance to dig in on these yet.
> 
> Aneesh are you able to run the ndctl unit tests? Even if they don't
> run on powerpc you should be able to get them to run on x86 qemu just
> to catch the basics.
> 

Thanks for the feedback. I will test the series with qemu.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
