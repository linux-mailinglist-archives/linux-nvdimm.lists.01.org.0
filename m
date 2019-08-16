Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF7909A2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 22:51:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 68638202B75CA;
	Fri, 16 Aug 2019 13:52:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9B0F720294F3B
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 13:52:49 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD16B3086208;
 Fri, 16 Aug 2019 20:51:01 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F3EF10016EB;
 Fri, 16 Aug 2019 20:51:01 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] libnvdimm/security: Consolidate 'security' operations
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156583202899.2815870.9164783407864995953.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 16 Aug 2019 16:51:00 -0400
In-Reply-To: <156583202899.2815870.9164783407864995953.stgit@dwillia2-desk3.amr.corp.intel.com>
 (Dan Williams's message of "Wed, 14 Aug 2019 18:20:29 -0700")
Message-ID: <x49v9uwbzrf.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 16 Aug 2019 20:51:01 +0000 (UTC)
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
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> The security operations are exported from libnvdimm/security.c to
> libnvdimm/dimm_devs.c, and libnvdimm/security.c is optionally compiled
> based on the CONFIG_NVDIMM_KEYS config symbol.
>
> Rather than export the operations across compile objects, just move the
> __security_store() entry point to live with the helpers.
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Fine by me.

Acked-by: Jeff Moyer <jmoyer@redhat.com>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
