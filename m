Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5736C4BC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 03:56:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D3AD212C01EA;
	Wed, 17 Jul 2019 18:59:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CD320212C01DB
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:59:01 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t76so20235688oih.4
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0/wNQNg34TlSm784FlVuDX0x6gqhqorLChgBFBK9ubQ=;
 b=Vsgkma42FV6YcYGuUHsl55kt7Fp+knXGzz7xjR2fRqesZ+HjoFQfWOQga9lIst7zoK
 M50w0w71MQeHFiK2B7iHWYwc2ZDofmDAV0LthA/BRohjn36VCDIgkSSsXzTYwknRbEqX
 bWg3MV7q0PhzQxqE60MmSubbV8zZWYzlW/xN8IP68pg3LmTDytPLCu+Rv7JFKF53Vgcr
 xGN7tEUkS4VCxBbYNA7+QDc3At/v6BfZpb1ZNNPgPw0wGLxxrhLtpCMea96N+m4gQZ+G
 4fDcZK3nt4ewLhRVvFYc9zxcRmb07Kvt7iSw9ZFivHVeOVj4D6gcov82kNE3fg1gSCB9
 OAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0/wNQNg34TlSm784FlVuDX0x6gqhqorLChgBFBK9ubQ=;
 b=mhbuCOfPf/znrHEEUDuMHf8eCS3I6hQduW5dQ5lGX/CQWSKX/S0AUctKgvsg+xSDoB
 4+YdOMvyAjYPcBI89dkfEMN86Htl5Y0lb+K9x7/zJd8nrm/s8tfcaqOfJmOgBdPPwz2M
 ZseUKHfz3ejqs76VHmGXqdqHqMu52ccUO1mRdGuYTjhopVC6/AR6xtdWVrERGPugQJD1
 iaeApHTYpzU7/xsdsI0MgsyyTmAU7ejGltH3Zj2A5kUevHngfWOQIJhF/HVQlJpPBuLk
 kLcdGgHlNGI3Rj68IPPf0n2AC72OJWT8j82FPyqzDZ/D/QoAXG27Mbq/joARam0uTPFK
 +NqQ==
X-Gm-Message-State: APjAAAWVmuCoXoT2xxlOpcuUKekFQqAxdBbrAkJ3mnAHxOBSJbZr5yny
 mXOsp7v6XyUT1QBskI3PVaWL2W2dVErxHwbblZ9RbRjs/aQ=
X-Google-Smtp-Source: APXvYqzDa24Zp8nALeZrKeksotlYlqp9E4MKD4gfOZQjy4h1xLhsKSdvyra9eCBi91FisfkFw+MGqvA6vhTdqhFaKPA=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr21578065oig.105.1563414992747; 
 Wed, 17 Jul 2019 18:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-4-vishal.l.verma@intel.com>
In-Reply-To: <20190717225400.9494-4-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Jul 2019 18:56:21 -0700
Message-ID: <CAPcyv4jsY1veeB46zJ8+G3a8L512=buW4jLY11tzoDopx+DgOA@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 03/13] libdaxctl: add an interface to retrieve
 the device resource
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add an interface to retrieve the 'resource' attribute for a dax device.
>
> Attempt to retrieve it as usual via sysfs, but since older kernels may
> be missing this attribute, as a fallback, attempt to retrieve it from
> /proc/iomem
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> [fscanf format string problem and diagnosis]
> Reported-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks ok, just wish we had added a dax resource sysfs attribute
earlier. That fscanf() line is a work of art.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
