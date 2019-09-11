Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163CB02D6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Sep 2019 19:42:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5956121962301;
	Wed, 11 Sep 2019 10:43:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vishal@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8FD2B202BDCAD
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 10:43:02 -0700 (PDT)
Received: from vverma7-desk1.lm.intel.com (fmdmzpr03-ext.fm.intel.com
 [192.55.54.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 66AF02081B;
 Wed, 11 Sep 2019 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568223773;
 bh=4AhEgo9vl2f7omSzUtySKEhZ1c9Xcy2rH8glTF9VUJI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=VSwhVdE5fzpuM29yDxj3kKqssprsCZq42/I4RTqz8FVYizhVDlZs5VzWJ/FvY9Men
 ZHALWRkR+GGk0sY3gQybt83dt6VV0X6ymalcnDm8a2E/fsZ2r/RHRe8AdbqDcxwECl
 XnDBLr3PQqJ5e4aP4Mb09LFGTrtTF1j6dyprKyLQ=
Message-ID: <71b87dfa4de7c85f4f888f001b23609d0a07b2c8.camel@kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
From: Vishal Verma <vishal@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Date: Wed, 11 Sep 2019 11:42:52 -0600
In-Reply-To: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> Document the basic policies of the libnvdimm subsystem and provide a first
> example of a Maintainer Entry Profile for others to duplicate and edit.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/nvdimm/maintainer-entry-profile.rst |   64 +++++++++++++++++++++
>  MAINTAINERS                                       |    4 +
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
> 
Looks good to me,
Acked-by: Vishal Verma <vishal.l.verma@intel.com>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
