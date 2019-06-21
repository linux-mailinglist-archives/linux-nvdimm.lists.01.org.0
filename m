Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF34DE34
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 02:53:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4037A2129F0EF;
	Thu, 20 Jun 2019 17:53:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CF9102129F0EB
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 17:53:48 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e8so4632442otl.7
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IghIqITuGVBjgBvbbflv0TslA9+YilTAx3aDj+IKW0E=;
 b=iSUEzSFfmatZoJgKO1yj/Kcbx3Ywzei9QORLaR3Ctk/x/ZYE9lzCOtEprPLVw0JUmv
 e13psNOsRtWfcQB5DP4gjXZ+W67oU/THRjMaePL9RklilCagvxOCdWt2wqmYBo/G/hZJ
 BF53dTAMBZg+GSYbRutW2r3Kb9wAq82+yBo0pOfZimU+uELWz6e277eESoPJ5ltQj7fh
 Vp5uWFCUjk73zisVQgonagRy/navlO+k6ayJUPF8Mw2iLVsIUyelwZSrmXHMP4v5bTEr
 LHfazDoivo65gBtWJzg8uQ5nBE46PmVGr2J+/msk0Oa0gJQdaHhYGOrp+RToECfW9iI1
 5Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IghIqITuGVBjgBvbbflv0TslA9+YilTAx3aDj+IKW0E=;
 b=r/5+Jcf6WZX0n/k7WQc+okw+wttaONL7XvHRlyUMQ1sxJ9otW9t+sSlZ1OMiLlRlEn
 ERW3+qzK+uiLYhojE+U1sWYZykTSTldawtRprPiJ/qkBPDWfR0McuNinexDR1xmS6KhT
 0C8DlWhdfKxg+9+OS8qrmYEQ9hwVat68X0i4Pm/enP0qN+Ta+jio++eS42V2ajkLAZxv
 qDNTmpDcKkheMAei52cupeIoeH35OgcRVDUIJLjyLF8xYgBXD9vRc3DhsI8Rh1sgtrCb
 +FwY+23oSRszd4R7XRBqhYT/ztLLt5pYfffDmTh+t6aLIlwdb6+f3KHTSS7b8ZEVUyjl
 kKFg==
X-Gm-Message-State: APjAAAXM8R70rWiuPJus6CfNEmQr2S5Ed9GTu5IxKgkPnGooWZ5X54i8
 zOqrpx66qvasbBEqJoh/TK1m0p13CM4Ag+IThrgYDQ==
X-Google-Smtp-Source: APXvYqx5KcOBOzPCKgbcSAH1KU0s2av7WgxnuPirQK4Cf1comzME+lU9tyw6zXdJxCrPsxTVvDEls2SfMF3l78DzMSw=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr41545473otf.126.1561078427423; 
 Thu, 20 Jun 2019 17:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190621004038.15180-1-vishal.l.verma@intel.com>
In-Reply-To: <20190621004038.15180-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 20 Jun 2019 17:53:36 -0700
Message-ID: <CAPcyv4hzK12RKns5pybmy=5B-yfCQ+-C4FO+2kRGjRZP4wa5GQ@mail.gmail.com>
Subject: Re: [PATCH] device-dax: Add a 'resource' attribute
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 20, 2019 at 5:41 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> device-dax based devices were missing a 'resource' attribute to indicate
> the physical address range contributed by the device in question. This
> information is desirable to userspace tooling that may want to use the
> dax device as system-ram, and wants to selectively hotplug and online
> the memory blocks associated with a given device.
>
> Without this, the tooling would have to parse /proc/iomem for the memory
> ranges contributed by dax devices, which can be a workaround, but it is
> far easier to provide this information in the sysfs hierarchy.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me, applied.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
