Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B4622655
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 May 2019 10:55:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3BBFF21237817;
	Sun, 19 May 2019 01:55:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EDCB52122B976
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 01:55:45 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4J8pL6c121013
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 04:55:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sjy9jgynq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 04:55:44 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Sun, 19 May 2019 09:55:42 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 19 May 2019 09:55:38 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4J8tbea57933866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 19 May 2019 08:55:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA26E42042;
 Sun, 19 May 2019 08:55:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 774024203F;
 Sun, 19 May 2019 08:55:36 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.50.203])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 19 May 2019 08:55:36 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: Re: [PATCH] mm/nvdimm: Pick the right alignment default when creating
 dax devices
In-Reply-To: <de5cbe7d-bd47-6793-1f1a-2274c5c59eb5@linux.ibm.com>
References: <20190514025449.9416-1-aneesh.kumar@linux.ibm.com>
 <875zq9m8zx.fsf@vajain21.in.ibm.com>
 <de5cbe7d-bd47-6793-1f1a-2274c5c59eb5@linux.ibm.com>
Date: Sun, 19 May 2019 14:25:33 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19051908-4275-0000-0000-000003365BFF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051908-4276-0000-0000-00003845EA00
Message-Id: <87sgtaddru.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-19_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=997 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905190066
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
Cc: linux-mm@kvack.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Hi Dan,

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> On 5/17/19 8:19 PM, Vaibhav Jain wrote:
>> Hi Aneesh,
>> 

....

>>
>>> +	/*
>>> +	 * Check whether the we support the alignment. For Dax if the
>>> +	 * superblock alignment is not matching, we won't initialize
>>> +	 * the device.
>>> +	 */
>>> +	if (!nd_supported_alignment(align) &&
>>> +	    memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
>> Suggestion to change this check to:
>> 
>> if (memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN) &&
>>     !nd_supported_alignment(align))
>> 
>> It would look  a bit more natural i.e. "If the device has dax signature and alignment is
>> not supported".
>> 
>
> I guess that should be !memcmp()? . I will send an updated patch with 
> the hash failure details in the commit message.
>

We need clarification on what the expected failure behaviour should be.
The nd_pmem_probe doesn't really have a failure behaviour in this
regard. For example.

I created a dax device with 16M alignment

{                                          
  "dev":"namespace0.0",
  "mode":"devdax",                         
  "map":"dev",                             
  "size":"9.98 GiB (10.72 GB)",
  "uuid":"ba62ef22-ebdf-4779-96f5-e6135383ed22",
  "raw_uuid":"7b2492f9-7160-4ee9-9c3d-2f547d9ef3ee",
  "daxregion":{                            
    "id":0,                                
    "size":"9.98 GiB (10.72 GB)",
    "align":16777216,
    "devices":[                            
      {                                    
        "chardev":"dax0.0",
        "size":"9.98 GiB (10.72 GB)"
      }                                    
    ]                                      
  },                                       
  "align":16777216,                        
  "numa_node":0,                           
  "supported_alignments":[
    65536,                                 
    16777216                               
  ]                                        
}      

Now what we want is to fail the initialization of the device when we
boot a kernel that doesn't support 16M page size. But with the
nd_pmem_probe failure behaviour we now end up with

[
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"mem",
    "size":10737418240,
    "uuid":"7b2492f9-7160-4ee9-9c3d-2f547d9ef3ee",
    "blockdev":"pmem0"
  }
]

So it did fallthrough the

	/* if we find a valid info-block we'll come back as that personality */
	if (nd_btt_probe(dev, ndns) == 0 || nd_pfn_probe(dev, ndns) == 0
			|| nd_dax_probe(dev, ndns) == 0)
		return -ENXIO;

	/* ...otherwise we're just a raw pmem device */
	return pmem_attach_disk(dev, ndns);


Is it ok if i update the code such that we don't do that default
pmem_atach_disk if we have a label area?

-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
