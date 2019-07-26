Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0975D38
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jul 2019 04:53:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECB26212E13CE;
	Thu, 25 Jul 2019 19:55:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 35A38212E13BB
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 19:55:27 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b7so3745974otl.11
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 19:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sjv4cEhc/3TzNZxW8W6Z2yU33+9CGLMSJTn3XzX/UtI=;
 b=V08+YIEUy87FSeuZmsAhjVe/pPcTbCkMZR01G+bqLLhjbZNK7jtKOrxvRghDzSg3PS
 f3KYa50fA6I254h4BznxqwC5SRiJrEEMJcJJ3uYmTvtXE84+/LOCZTX5R71E/bHFT/Ee
 S8OOX7h4zwAL2yK0azU9A1wDWhaDLsaTufGDf1D1bs9LSYT/yRuHJRypcN1wJBIfQuzC
 GyQYgFLkCSzW0M1Bd7YLNiKIg5FZNLNLEjQTKjftizBOCPqZ6ITAMRpWvpNkAfVN0EOP
 niMP9Kd15/vCW+qx6Scxw3Alb/F76rxlA5m5vwcABtRGXjlv62Eug0hpMcEFWCX/W2+Y
 r9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sjv4cEhc/3TzNZxW8W6Z2yU33+9CGLMSJTn3XzX/UtI=;
 b=fH9oyO0t3x9kcIURvBzinPSAkzL88WXMbIANrPT2OSGoUmNjSpfFp57jdpR3Lo/LwR
 USWnTKp6l2vB+o62r1l3HBZKKhXHkAI87lIlc0oj44UqVPsD+EBvIF/hmNVxe+EDavJv
 BFAl8kCeJB2aGOC8POaBgfayMmVGM2oO+jHUiuAaZbzdJWmpw/f3FVMFsjoyvKetVGdF
 wuxhxdZgfIVNZ7Xc3YU+KEa/9852Ebua3xV0JarbYGvr2tyRB6GNrmntD24WR32yZakF
 voHFH5/Rzq3OkV9XKnC0zplK88tOgzTMPhgkZ0htEvFQspIGN3MnZ3LWAMo+8hhL4pbv
 /vZQ==
X-Gm-Message-State: APjAAAWodZA2fE3uSVF/bBGRyiS7okBM90/8SWoLdXjugKuYsAND1iIU
 eCMo8IozrSSKcKD7SF9+qU8IcCBmD57fw5eh3uUdug==
X-Google-Smtp-Source: APXvYqyfF5t1O/RsqRb/VRHZlV0s/DbUbYZKSQBX9P/y9+RRpyK4rpyR311BTFoFn692VFOgi2Ph5lQn4V6teM5OlSQ=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr34227881otn.247.1564109579843; 
 Thu, 25 Jul 2019 19:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
 <20190724215741.18556-11-vishal.l.verma@intel.com>
In-Reply-To: <20190724215741.18556-11-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 25 Jul 2019 19:52:49 -0700
Message-ID: <CAPcyv4ja-6AvDeetGR-vFSRZ1sf9tthkB2MGjuLcbAROsupBdg@mail.gmail.com>
Subject: Re: [ndctl PATCH v7 10/13] Documentation: Add man pages for
 daxctl-{on, off}line-memory
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
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 24, 2019 at 2:58 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add man pages for the two new commands: daxctl-online-memory, and
> daxctl-offline-memory.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
