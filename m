Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C72096E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 16:23:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20CB32125ADC8;
	Thu, 16 May 2019 07:23:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 05DCD21250C98
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 07:23:45 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2AD93083392;
 Thu, 16 May 2019 14:23:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F70F5D6A9;
 Thu, 16 May 2019 14:23:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 20E57220386; Thu, 16 May 2019 10:23:42 -0400 (EDT)
Date: Thu, 16 May 2019 10:23:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 12/30] dax: remove block device dependencies
Message-ID: <20190516142342.GA31638@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-13-vgoyal@redhat.com>
 <CAPcyv4i_-ri=w0jYJ4WjK4QD9E8pMzkGQNdMbt9H_nawDqYD3A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_-ri=w0jYJ4WjK4QD9E8pMzkGQNdMbt9H_nawDqYD3A@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 16 May 2019 14:23:45 +0000 (UTC)
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
Cc: KVM list <kvm@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 15, 2019 at 05:21:51PM -0700, Dan Williams wrote:

[..]
> It just seems to me that we should stop pretending that the
> filesystem-dax facility requires block devices and try to move this
> functionality to generically use a dax device across all interfaces.

That sounds reasonable and will help with our use case where we don't
have the block device at all.

Vivek
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
