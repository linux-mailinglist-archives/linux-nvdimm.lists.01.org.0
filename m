Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D4A7C49
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 09:06:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 39A8E21962301;
	Wed,  4 Sep 2019 00:07:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D60E02021B6E4
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 00:07:45 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8472pGm086724; Wed, 4 Sep 2019 03:06:36 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ut7edj4xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 03:06:36 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8474cpI032192;
 Wed, 4 Sep 2019 07:06:35 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02dal.us.ibm.com with ESMTP id 2uqgh75amf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 07:06:35 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8476YBC55312660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Sep 2019 07:06:34 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 425486A051;
 Wed,  4 Sep 2019 07:06:34 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B5C26A047;
 Wed,  4 Sep 2019 07:06:33 +0000 (GMT)
Received: from [9.199.33.228] (unknown [9.199.33.228])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  4 Sep 2019 07:06:32 +0000 (GMT)
Subject: Re: [PATCH v7 7/7] libnvdimm/dax: Pick the right alignment default
 when creating dax devices
To: dan.j.williams@intel.com
References: <20190904050822.23139-1-aneesh.kumar@linux.ibm.com>
 <20190904050822.23139-8-aneesh.kumar@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <77c345a4-a317-2f42-f21c-4c2c98983565@linux.ibm.com>
Date: Wed, 4 Sep 2019 12:36:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904050822.23139-8-aneesh.kumar@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-04_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040072
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
Cc: linux-nvdimm@lists.01.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/4/19 10:38 AM, Aneesh Kumar K.V wrote:
> Allow arch to provide the supported alignments and use hugepage alignment only
> if we support hugepage. Right now we depend on compile time configs whereas this
> patch switch this to runtime discovery.
> 
> Architectures like ppc64 can have THP enabled in code, but then can have
> hugepage size disabled by the hypervisor. This allows us to create dax devices
> with PAGE_SIZE alignment in this case.
> 
> Existing dax namespace with alignment larger than PAGE_SIZE will fail to
> initialize in this specific case. We still allow fsdax namespace initialization.
> 
> With respect to identifying whether to enable hugepage fault for a dax device,
> if THP is enabled during compile, we default to taking hugepage fault and in dax
> fault handler if we find the fault size > alignment we retry with PAGE_SIZE
> fault size.
> 
> This also addresses the below failure scenario on ppc64
> 
> ndctl create-namespace --mode=devdax  | grep align
>   "align":16777216,
>   "align":16777216
> 
> cat /sys/devices/ndbus0/region0/dax0.0/supported_alignments
>   65536 16777216
> 
> daxio.static-debug  -z -o /dev/dax0.0
>    Bus error (core dumped)
> 
>    $ dmesg | tail
>     lpar: Failed hash pte insert with error -4
>     hash-mmu: mm: Hashing failure ! EA=0x7fff17000000 access=0x8000000000000006 current=daxio
>     hash-mmu:     trap=0x300 vsid=0x22cb7a3 ssize=1 base psize=2 psize 10 pte=0xc000000501002b86
>     daxio[3860]: bus error (7) at 7fff17000000 nip 7fff973c007c lr 7fff973bff34 code 2 in libpmem.so.1.0.0[7fff973b0000+20000]
>     daxio[3860]: code: 792945e4 7d494b78 e95f0098 7d494b78 f93f00a0 4800012c e93f0088 f93f0120
>     daxio[3860]: code: e93f00a0 f93f0128 e93f0120 e95f0128 <f9490000> e93f0088 39290008 f93f0110
> 
> The failure was due to guest kernel using wrong page size.
> 
> The namespaces created with 16M alignment will appear as below on a config with
> 16M page size disabled.
> 
> $ ndctl list -Ni
> [
>    {
>      "dev":"namespace0.1",
>      "mode":"fsdax",
>      "map":"dev",
>      "size":5351931904,
>      "uuid":"fc6e9667-461a-4718-82b4-69b24570bddb",
>      "align":16777216,
>      "blockdev":"pmem0.1",
>      "supported_alignments":[
>        65536
>      ]
>    },
>    {
>      "dev":"namespace0.0",
>      "mode":"fsdax",    <==== devdax 16M alignment marked disabled.
>      "map":"mem",
>      "size":5368709120,
>      "uuid":"a4bdf81a-f2ee-4bc6-91db-7b87eddd0484",
>      "state":"disabled"
>    }
> ]
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

v8 for this posted at

https://patchwork.kernel.org/patch/11129463/

-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
