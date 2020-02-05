Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF4153919
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 20:28:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F342910FC33F6;
	Wed,  5 Feb 2020 11:31:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5368C10FC33F6
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 11:31:38 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015JNeKq023763;
	Wed, 5 Feb 2020 19:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MRxTEb/TAwReEwri4knyMEV5v+tQpMHdBF3fW9aEiWo=;
 b=F+pPEYtWMOpP3QVi6yp3L0G/8LlX9kW44Ojw2aNJa1C2G11fCOVJd5ohr/q7NcrX1sxv
 h2JZoXC/Z/HQcj8qNOi5KefF2YMTu/c642LJa0hk4zqxBYLbqxEHCuK3NS4GTqFMlfnu
 eG3flMqE+/iBo24UQNr1XP5BVZosetmaDWSqhiiTpso+21VbsXAFfdUVKh7dBwi/Kvp9
 VdVdu/2whSvypwDE20tY9H6ixeRxjqIVpcJGG9wpFBGn8PFsh7sgIEUrbKa5TbHyIf6e
 ClWHsJEQYR47Q20xTBYlxqK8tb9vSHopKTJbyBP/W28G+iMv1Q7xYSBf1Vk5JYAB2VLw lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=MRxTEb/TAwReEwri4knyMEV5v+tQpMHdBF3fW9aEiWo=;
 b=pZRZoWGAzqoWwKfs0j3qNfSX8+MyA6dfTz7Hpr4LXkuf8raCNeqzv3i7C/cuQ4Bn2sec
 xr4DLMEAuFP20HhQ4v6uvwtUL5Rftv10hnroik3qIDfrU2cRIuQkr+q2qumbcKqUriIY
 AEdTexztemRlW9W/GwCrdxI19YvQiKbNBE7ho4k7ieJpeiPngOFK5TeFr+J9tInpL8OD
 TPudaECxpXCdKwGtBFdiXvByjdfqIbmUPeFeWp+rA9MFG3bap+S/urIk9a5j2jteK35k
 RQi0kzVngKN9r0/vNROIqIC30gcnPUbxQAGjVNFEVfTqQYy8p4IMzpRo0V0F3+cKT8mk fg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2xykbpd6qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 19:28:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015JNiwC099752;
	Wed, 5 Feb 2020 19:28:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 2xykc84wgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 19:28:18 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015JSHRx027153;
	Wed, 5 Feb 2020 19:28:17 GMT
Received: from kadam (/10.175.200.151)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Feb 2020 11:28:16 -0800
Date: Wed, 5 Feb 2020 22:28:06 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
Message-ID: <20200205192806.GE24804@kadam>
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
 <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
 <20200205181040.GC24804@kadam>
 <CAPcyv4itFypOmv38Oo=DRWk_1Y3PFhPpYPDzxShmZVY9ZsTNLA@mail.gmail.com>
 <20200205190845.GD24804@kadam>
 <CAPcyv4jkTHeS2zTmYRoFi+evMemhmMkvPVcsBOQGXinGq6JyiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jkTHeS2zTmYRoFi+evMemhmMkvPVcsBOQGXinGq6JyiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=888
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=958 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050149
Message-ID-Hash: 2VRRV2KD6HDJ3RILGFBWIOKPXUCDKWWX
X-Message-ID-Hash: 2VRRV2KD6HDJ3RILGFBWIOKPXUCDKWWX
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2VRRV2KD6HDJ3RILGFBWIOKPXUCDKWWX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 11:16:22AM -0800, Dan Williams wrote:
> Ugh, sorry I thought you were pointing out that there's too many
> put_device() not the use after free. Yes, the use after free is a bug
> that needs fixing.

I am complaining about the device_puts...  If we call device_put()
twice then it cause a problem in __nvdimm_create()

drivers/nvdimm/dimm_devs.c
   506          nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
   507          nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
   508          nd_device_register(dev);
   509  
   510          return nvdimm;
                       ^^^^^^
If we call device_put() twice then we this pointer within 4 seconds.

   511  }

The fix is probably to make nd_device_register() return an error code so
we can do:

	ret = nd_device_register(dev);
	if (ret) {
		device_put(&nvdimm->dev);
		return NULL;
	}

	return nvdimm;

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
