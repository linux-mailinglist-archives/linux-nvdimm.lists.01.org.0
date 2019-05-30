Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6832F86F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 May 2019 10:20:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 811CB212794AD;
	Thu, 30 May 2019 01:20:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 119A421276B8F
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 01:20:44 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4U8IXZC078522
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 04:20:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sta87kxpb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 04:20:43 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 30 May 2019 09:20:40 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 30 May 2019 09:20:39 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4U8KcMq43516110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2019 08:20:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB794A4060;
 Thu, 30 May 2019 08:20:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A2E6A405C;
 Thu, 30 May 2019 08:20:37 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.31.115])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 May 2019 08:20:36 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com
Subject: Re: Picking 0th namespace if it is idle
In-Reply-To: <87a7f45qik.fsf@linux.ibm.com>
References: <87a7f45qik.fsf@linux.ibm.com>
Date: Thu, 30 May 2019 13:50:35 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19053008-0012-0000-0000-00000320E0A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053008-0013-0000-0000-00002159AEFD
Message-Id: <877ea85p64.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-30_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300063
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

aneesh.kumar@linux.ibm.com (Aneesh Kumar K.V) writes:

> Hi Dan,
>
> With the patch series to mark the namespace disabled if we have mismatch
> in pfn superblock, we can endup with namespace0 marked idle/disabled.
>
> I am wondering why do do the below in ndctl.
>
>
> static struct ndctl_namespace *region_get_namespace(struct ndctl_region *region)
> {
> 	struct ndctl_namespace *ndns;
>
> 	/* prefer the 0th namespace if it is idle */
> 	ndctl_namespace_foreach(region, ndns)
> 		if (ndctl_namespace_get_id(ndns) == 0
> 				&& !is_namespace_active(ndns))
> 			return ndns;
> 	return ndctl_region_get_namespace_seed(region);
> }
>
> I have a kernel patch that will create a namespace_seed even if we fail
> to ename a pfn backing device. Something like below
>  
> @@ -747,12 +752,23 @@ static void nd_region_notify_driver_action(struct nvdimm_bus *nvdimm_bus,
>  		}
>  	}
>  	if (dev->parent && is_nd_region(dev->parent) && probe) {
>  		nd_region = to_nd_region(dev->parent);
>  		nvdimm_bus_lock(dev);
>  		if (nd_region->ns_seed == dev)
>  			nd_region_create_ns_seed(nd_region);
>  		nvdimm_bus_unlock(dev);
>  	}
> +
> +	if (dev->parent && is_nd_region(dev->parent) && !probe && (ret == -EOPNOTSUPP)) {
> +		nd_region = to_nd_region(dev->parent);
> +		nvdimm_bus_lock(dev);
> +		if (nd_region->ns_seed == dev)
> +			nd_region_create_ns_seed(nd_region);
> +		nvdimm_bus_unlock(dev);
> +	}
> +
>
> With that we can end up with something like the below after boot.
> :/sys/bus/nd/devices/region0$ sudo ndctl list -Ni        
> [                                                                          
>   {                                                                                                                                                    
>     "dev":"namespace0.1",                                                  
>     "mode":"fsdax",                                                        
>     "map":"mem",                                                           
>     "size":0,                                                              
>     "uuid":"00000000-0000-0000-0000-000000000000",                                                                                                     
>     "state":"disabled"                                                     
>   },                                                                       
>   {                                                                        
>     "dev":"namespace0.0",                                                  
>     "mode":"fsdax",                  
>     "map":"mem",                                                           
>     "size":2147483648,               
>     "uuid":"094e703b-4bf8-4078-ad42-50bebc03e538",                                                                                                     
>     "state":"disabled"                                                                                                                                 
>   }                                                                        
> ]                                             
>
> namespace0.0 is the one we failed to initialize due to PAGE_SIZE
> mismatch. 
>
> We do have namespace_seed pointing to namespacece0.1 correct. But a ndtl
> create-namespace will pick namespace0.0 even if we have seed file
> pointing to namespacec0.1.
>
>
> I am trying to resolve the issues related to creation of new namespaces
> when we have some namespace marked disabled due to pfn_sb setting
> mismatch.
>
> -aneesh

With that ndctl namespace0.0 selection commented out, we do get pick the
right idle namespace.

#ndctl list -Ni
[                         
  {                
    "dev":"namespace0.1",
    "mode":"fsdax",                                                        
    "map":"mem",      
    "size":0,
    "uuid":"00000000-0000-0000-0000-000000000000",
    "state":"disabled"   
  },               
  {             
    "dev":"namespace0.0",
    "mode":"fsdax",                                                        
    "map":"mem",  
    "size":2147483648,   
    "uuid":"0c31ae4b-b053-43c7-82ff-88574e2585b0",
    "state":"disabled"
  }  
]   

after ndctl create-namespace -s 2G -r region0                   


# ndctl list -Ni                                           
[                     
  {                    
    "dev":"namespace0.2",
    "mode":"fsdax",       
    "map":"mem",   
    "size":0,   
    "uuid":"00000000-0000-0000-0000-000000000000",
    "state":"disabled"
  },
  {
    "dev":"namespace0.1",
    "mode":"fsdax",
    "map":"dev",
    "size":2130706432,
    "uuid":"60970059-9412-4eeb-9e7a-b314585a4da3",
    "align":65536,
    "blockdev":"pmem0.1",
    "supported_alignments":[
      65536
    ]
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"mem",
    "size":2147483648,
    "uuid":"0c31ae4b-b053-43c7-82ff-88574e2585b0",
    "state":"disabled"
  }
]

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
