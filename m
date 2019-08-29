Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB9A271D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 21:16:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B67E2021DD51;
	Thu, 29 Aug 2019 12:18:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1E77A20215F59
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 12:18:23 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TJ412X018195;
 Thu, 29 Aug 2019 19:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=i50TbjugzxgZVnpuOoQ34mHSZuh39oNlFbWjAQTnN3c=;
 b=NxeYm3DLDCUv2I4+f1bzefR9fD+Dec0BvbjuH9kShMOcYzsoJqSVt/8yCm3/PVY8Vk6I
 lIO94eQopgnpToKR+CEdaR79wx9uYbteOSGAkngcS5UjUrJmdI5Ls0tor9o5pDsm+we+
 naJ93/hsW2ObfxEEmZN17962y1DoI2nvSOYuJ5rX3sZuaS4SBkovP61IYcNRdIcdaVTG
 UOBGw8qQogNeGta2kaSf5BvNzQMi8oEX0JDYizKiM8FDUs0f4ErEibDGQ7z/2oQIEV5y
 PjXhnWLe33RIBlFS7habICV+MEFZEgXzZSNtQRmHUyxSu++0Bx331STFn1MCVwcd03e8 uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2upm8r06wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 19:16:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TJ4Bpx050265;
 Thu, 29 Aug 2019 19:16:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2upkrfb8b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 19:16:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7TJGTlE014518;
 Thu, 29 Aug 2019 19:16:29 GMT
Received: from [10.132.92.146] (/10.132.92.146)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 29 Aug 2019 12:16:29 -0700
Subject: Re: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
To: Dan Williams <dan.j.williams@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
 <20190829001735.30289-4-vishal.l.verma@intel.com>
 <179261bd-9812-6bba-6710-19a77cf3acc6@oracle.com>
 <e343ace46d7243632eec594f679759fac78814ba.camel@intel.com>
 <CAPcyv4iQ8=yLGA0E2=puqV+mC7HxNW-RP-0EtVeU2hN6HsNxKQ@mail.gmail.com>
From: jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <bca384f1-46c9-54c5-2df3-e2575c57c694@oracle.com>
Date: Thu, 29 Aug 2019 12:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iQ8=yLGA0E2=puqV+mC7HxNW-RP-0EtVeU2hN6HsNxKQ@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290191
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290191
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
Cc: "Scargall, Steve" <steve.scargall@intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/29/19 11:28 AM, Dan Williams wrote:
> On Thu, Aug 29, 2019 at 11:08 AM Verma, Vishal L
> <vishal.l.verma@intel.com> wrote:
>>
>> On Thu, 2019-08-29 at 10:38 -0700, jane.chu@oracle.com wrote:
>>> Hi, Vishal,
>>>
>>>
>>> On 8/28/19 5:17 PM, Vishal Verma wrote:
>>>> Add a --continue option to ndctl-create-namespaces to allow the creation
>>>> of as many namespaces as possible, that meet the given filter
>>>> restrictions.
>>>>
>>>> The creation loop will be aborted if a failure is encountered at any
>>>> point.
>>>
>>> Just wondering what is the motivation behind providing this option?
>>
>> Hi Jane,
>>
>> See Steve's email here:
>> https://lists.01.org/pipermail/linux-nvdimm/2019-August/023390.html
>>
>> Essentially it lets sysadmins create a simple, maximal configuration
>> without everyone having to script it.
> 
> It also gives a touch point to start thinking about parallel namespace
> creation. The large advancements in boot time that Alex achieved were
> mainly from parallelizing namespace init. With --continue we could
> batch the namespace enable calls and kick off a bind thread per
> namespace.
> 

Thanks Dan!  Sorry I was reading email backwards, just caught up with 
the earlier discussions.

With the --continue option, assuming the --size option will be taken if 
specified, it would be possible to end up with a large number of small 
namespaces
with a simple command that runs for a long while, right? can it be 
killed by ctrl-c once the innocent user regrets? :)

thanks,
-jane

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
