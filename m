Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F07B93B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 07:46:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30C25212E8437;
	Tue, 30 Jul 2019 22:49:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=yizhan@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8BE8B212E4B7A
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 22:49:15 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B536A33025F;
 Wed, 31 Jul 2019 05:46:44 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AABEF600CC;
 Wed, 31 Jul 2019 05:46:44 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9FD8F1800203;
 Wed, 31 Jul 2019 05:46:44 +0000 (UTC)
Date: Wed, 31 Jul 2019 01:46:44 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvdimm@lists.01.org
Message-ID: <1497200704.3777491.1564552004435.JavaMail.zimbra@redhat.com>
In-Reply-To: <1254901996.3735926.1564533684889.JavaMail.zimbra@redhat.com>
References: <1254901996.3735926.1564533684889.JavaMail.zimbra@redhat.com>
Subject: Re: create devdax with "-a 1g" failed from 5.3.0-rc1
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.24]
Thread-Topic: create devdax with "-a 1g" failed from 5.3.0-rc1
Thread-Index: Z1n1hgEBR4VyP9vtKw8awNhVRh2JQ+FgyG6l
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 31 Jul 2019 05:46:44 +0000 (UTC)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

seems it blocked the attachment, I paste all the log here:

https://pastebin.com/5APNheTC

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Yi Zhang" <yi.zhang@redhat.com>
To: "dan j williams" <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org
Sent: Wednesday, July 31, 2019 8:41:24 AM
Subject: create devdax with "-a 1g" failed from 5.3.0-rc1

Hi Dan

As subject, I found it failed from bellow commit[1], steps list here [2] and I've attached the full dmesg, let me know if you need more info, thanks.

[1]
commit a3619190d62ed9d66416891be2416f6bea2b3ca4 (refs/bisect/bad)
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Thu Jul 18 15:58:40 2019 -0700

    libnvdimm/pfn: stop padding pmem namespaces to section alignment

[2]
# ./ndctl destroy-namespace all -r all -f
destroyed 5 namespaces
# ./ndctl create-namespace -r region1 -m devdax -a 1g -s 12G -vv
libndctl: ndctl_dax_enable: dax1.0: failed to enable
  Error: namespace1.0: failed to enable

failed to create namespace: No such device or address
# ./ndctl -v
65



Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
