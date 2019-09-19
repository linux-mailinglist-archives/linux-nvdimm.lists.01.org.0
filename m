Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3EAB71FE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 05:49:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5021E202EA958;
	Wed, 18 Sep 2019 20:48:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 308E4202EA928
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 20:48:18 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8J3kjj2051023; Wed, 18 Sep 2019 23:49:05 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v40jht7ye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2019 23:49:05 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8J3idw8031431;
 Thu, 19 Sep 2019 03:49:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03wdc.us.ibm.com with ESMTP id 2v3vbua782-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Sep 2019 03:49:05 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8J3n4bc44564856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2019 03:49:04 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 185996E04C;
 Thu, 19 Sep 2019 03:49:04 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DBA96E050;
 Thu, 19 Sep 2019 03:49:03 +0000 (GMT)
Received: from [9.199.35.37] (unknown [9.199.35.37])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 19 Sep 2019 03:49:02 +0000 (GMT)
Subject: Re: [PATCH v2] libnvdimm/region: Initialize bad block for volatile
 namespaces
To: Dan Williams <dan.j.williams@intel.com>
References: <20190917152544.11216-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hs3eAp-=6_9k6UqACafsiR2PpapdXOAVEiS5PeChFFOg@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <d4466bb4-0747-fc6b-1847-98d707c999dc@linux.ibm.com>
Date: Thu, 19 Sep 2019 09:19:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hs3eAp-=6_9k6UqACafsiR2PpapdXOAVEiS5PeChFFOg@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-19_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190032
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/19/19 4:05 AM, Dan Williams wrote:
> On Tue, Sep 17, 2019 at 8:25 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> We do check for a bad block during namespace init and that use
>> region bad block list. We need to initialize the bad block
>> for volatile regions for this to work. We also observe a lockdep
>> warning as below because the lock is not initialized correctly
>> since we skip bad block init for volatile regions.
>>
>>   INFO: trying to register non-static key.
>>   the code is fine but needs lockdep annotation.
>>   turning off the locking correctness validator.
>>   CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc1-15699-g3dee241c937e #149
>>   Call Trace:
>>   [c0000000f95cb250] [c00000000147dd84] dump_stack+0xe8/0x164 (unreliable)
>>   [c0000000f95cb2a0] [c00000000022ccd8] register_lock_class+0x308/0xa60
>>   [c0000000f95cb3a0] [c000000000229cc0] __lock_acquire+0x170/0x1ff0
>>   [c0000000f95cb4c0] [c00000000022c740] lock_acquire+0x220/0x270
>>   [c0000000f95cb580] [c000000000a93230] badblocks_check+0xc0/0x290
>>   [c0000000f95cb5f0] [c000000000d97540] nd_pfn_validate+0x5c0/0x7f0
>>   [c0000000f95cb6d0] [c000000000d98300] nd_dax_probe+0xd0/0x1f0
>>   [c0000000f95cb760] [c000000000d9b66c] nd_pmem_probe+0x10c/0x160
>>   [c0000000f95cb790] [c000000000d7f5ec] nvdimm_bus_probe+0x10c/0x240
>>   [c0000000f95cb820] [c000000000d0f844] really_probe+0x254/0x4e0
>>   [c0000000f95cb8b0] [c000000000d0fdfc] driver_probe_device+0x16c/0x1e0
>>   [c0000000f95cb930] [c000000000d10238] device_driver_attach+0x68/0xa0
>>   [c0000000f95cb970] [c000000000d1040c] __driver_attach+0x19c/0x1c0
>>   [c0000000f95cb9f0] [c000000000d0c4c4] bus_for_each_dev+0x94/0x130
>>   [c0000000f95cba50] [c000000000d0f014] driver_attach+0x34/0x50
>>   [c0000000f95cba70] [c000000000d0e208] bus_add_driver+0x178/0x2f0
>>   [c0000000f95cbb00] [c000000000d117c8] driver_register+0x108/0x170
>>   [c0000000f95cbb70] [c000000000d7edb0] __nd_driver_register+0xe0/0x100
>>   [c0000000f95cbbd0] [c000000001a6baa4] nd_pmem_driver_init+0x34/0x48
>>   [c0000000f95cbbf0] [c0000000000106f4] do_one_initcall+0x1d4/0x4b0
>>   [c0000000f95cbcd0] [c0000000019f499c] kernel_init_freeable+0x544/0x65c
>>   [c0000000f95cbdb0] [c000000000010d6c] kernel_init+0x2c/0x180
>>   [c0000000f95cbe20] [c00000000000b954] ret_from_kernel_thread+0x5c/0x68
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>> Changes from V1:
>> * update commit subject
> 
> What about the is_nd_pmem() call in nvdimm_clear_badblocks_region()?
> 

Missed that. Yes that also needs an updatet. Will you be able to update 
that or you want me to send a V3?

-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
