Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A39347055
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 05:04:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 842E2100EBB61;
	Tue, 23 Mar 2021 21:04:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 658AC100EF267
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 21:04:28 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O42j4F096158;
	Wed, 24 Mar 2021 00:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KMzKvsJ+4PcCy7f2/cfJEV8IWxLjNZ1e+OGep2nWj+w=;
 b=lUrIZrsGDGJBs3lw6BDLsPaHvNr9ydPEIZjPAw4ycGlOkRi/3KcKcTuBqYFe60FXbOt5
 YdS4QZkGrEl2jRnZrpUVtU7HR6reKlVDSTXOHBoJi6HJRJBnpZ6W+n2FQI1nqCWcAOZU
 UWoWakcJnp1fZQfXjFffS5fV+KAtj/HyNfBj+bgIO2FVJ7KQOArXFY3h9VN7LAXZNa5c
 2BJ7cOdizYO62q1TFsJFM0+2PwPWr3lr+eWa3l3cp7jmT54Z/tvTqC6aefEh9oPwxcav
 cDoFl68uP0XOTeB/4b3yjdi2LyDQKi60NH7dmzHBowteFAbYYHdAmqByYg8YKSEPTa6g Iw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37fuq42st6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Mar 2021 00:04:14 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12O44EjG099912;
	Wed, 24 Mar 2021 00:04:14 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37fuq42ssn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Mar 2021 00:04:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12O42tRW024310;
	Wed, 24 Mar 2021 04:04:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma06ams.nl.ibm.com with ESMTP id 37d9bmkxg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Mar 2021 04:04:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12O449Dm40567082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Mar 2021 04:04:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8D1C4C046;
	Wed, 24 Mar 2021 04:04:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 101A64C05A;
	Wed, 24 Mar 2021 04:04:07 +0000 (GMT)
Received: from [9.85.94.223] (unknown [9.85.94.223])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 24 Mar 2021 04:04:06 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] spapr: nvdimm: Implement H_SCM_FLUSH hcall
To: David Gibson <david@gibson.dropbear.id.au>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>
References: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
 <161650725183.2959.12071056430236337803.stgit@6532096d84d3>
 <YFqs8M1dHAFhdCL6@yekko.fritz.box>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <19b5aa0b-df85-256d-d4c4-eacd0ea8312e@linux.ibm.com>
Date: Wed, 24 Mar 2021 09:34:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFqs8M1dHAFhdCL6@yekko.fritz.box>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_03:2021-03-23,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240029
Message-ID-Hash: UG7EG6S74YNVVK4ZXOQAJPE5PGKIT67T
X-Message-ID-Hash: UG7EG6S74YNVVK4ZXOQAJPE5PGKIT67T
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: sbhat@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, qemu-devel@nongnu.org, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UG7EG6S74YNVVK4ZXOQAJPE5PGKIT67T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 3/24/21 8:37 AM, David Gibson wrote:
> On Tue, Mar 23, 2021 at 09:47:38AM -0400, Shivaprasad G Bhat wrote:
>> The patch adds support for the SCM flush hcall for the nvdimm devices.
>> To be available for exploitation by guest through the next patch.
>>
>> The hcall expects the semantics such that the flush to return
>> with H_BUSY when the operation is expected to take longer time along
>> with a continue_token. The hcall to be called again providing the
>> continue_token to get the status. So, all fresh requsts are put into
>> a 'pending' list and flush worker is submitted to the thread pool.
>> The thread pool completion callbacks move the requests to 'completed'
>> list, which are cleaned up after reporting to guest in subsequent
>> hcalls to get the status.
>>
>> The semantics makes it necessary to preserve the continue_tokens
>> and their return status even across migrations. So, the pre_save
>> handler for the device waits for the flush worker to complete and
>> collects all the hcall states from 'completed' list. The necessary
>> nvdimm flush specific vmstate structures are added to the spapr
>> machine vmstate.
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> An overal question: surely the same issue must arise on x86 with
> file-backed NVDIMMs.  How do they handle this case?

On x86 we have different ways nvdimm can be discovered. ACPI NFIT, e820 
map and virtio_pmem. Among these virio_pmem always operated with 
synchronous dax disabled and both ACPI and e820 doesn't have the ability 
to differentiate support for synchronous dax.

With that I would expect users to use virtio_pmem when using using file 
backed NVDIMMS

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
