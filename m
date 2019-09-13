Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CFFB23A3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 17:46:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 373F0202EA3F5;
	Fri, 13 Sep 2019 08:46:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=robherring2@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C3341202E2912
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 08:46:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 201so28561983qkd.13
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XO70El4oS2tOzApEnum8feip+ENgacm8GuaL7eIjAHM=;
 b=AhblWwK/ROHlFbIbdNsCh7YKSiQqOvgtvVUg/nA45czjfbmYf3swhf+jd8vv5Nv2eE
 TOajmML3fZQqKooKG8Fw3e5TDIxCqjKhdH/ekU91iKoV0+jCPGgCyCjBsQF3zMzumpej
 MmaKBFBxLynI0g5CPUu3a9NN3tGgmF+PmJy5vLJw94ezrvqPGzQ7mnpqdKQPwgp7jOIe
 LaAAjUNA+7bzjNk1JXfVdS0aUPQBpSyHc2cRKejQLhS3s0ug8XSVDzEpvxySyt6egjs4
 G7imPpb0kaQRrEy8d0rYC/MQQPqwnV9g1YOW4o+7LEjbgw4HE+IGDQv84aUiM3SrzDEa
 t/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XO70El4oS2tOzApEnum8feip+ENgacm8GuaL7eIjAHM=;
 b=rXD67k4t0Xe+EFbQghmQveYNR3usx7J/75CWUeKKpQxNIkP06mfk4J+hF1rSFpr24S
 /G9bijHUUpd78CFJjE6AkguKqVwIHwcfZUiXkdaP41M9wktt+C+BqaBfqGJTvRd7ufKh
 9rpL92o/uBAWasgbTbnPc6gYDRiswIhFAJcUG16htOmdK3CnfTNNkzHQu0ojjo2NvZCF
 KD4OVmz+0qX85/PYM4AJ1YvTRkqmDr7pUqOg+NN9FkgiJr2RwOcTCGOHy6WTw565QEtP
 KXwcdPF8QSiShIIO6JmUs37RGtcRHTgw0z5Mu4GUHJKcp379BBBKvGJtbE/A5JgOV6LX
 oINA==
X-Gm-Message-State: APjAAAXjts7huVZdCVheOddFr16oOixiM2t8q3Th2R7SIwS2pZ+4PML1
 l+f1BDOBwND2N8zf6zr4g5Jw2RjtVt3eV1QYyw==
X-Google-Smtp-Source: APXvYqwkoYIPGED4jHTOIcDuuctuHZYBF5qjDvf9su4HjEVpVRrH0fkPzLII7bGDsE7EPykfDy10fpoUaYfUeHquyaA=
X-Received: by 2002:a37:682:: with SMTP id 124mr46792397qkg.393.1568389592307; 
 Fri, 13 Sep 2019 08:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
 <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
In-Reply-To: <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 13 Sep 2019 16:46:21 +0100
Message-ID: <CAL_JsqLo9-zQYGj2vaEWppbioO0rXu-QNbHhydYdMgrZo0_ESg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To: Randy Dunlap <rdunlap@infradead.org>
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
Cc: ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Jonathan Corbet <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 13, 2019 at 4:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/13/19 4:48 AM, Dan Carpenter wrote:
>
> >> So I'm expecting to take this kind of stuff into Documentation/.  My own
> >> personal hope is that it can maybe serve to shame some of these "local
> >> quirks" out of existence.  The evidence from this brief discussion suggests
> >> that this might indeed happen.
> >
> > I don't think it's shaming, I think it's validating.  Everyone just
> > insists that since it's written in the Book of Rules then it's our fault
> > for not reading it.  It's like those EULA things where there is more
> > text than anyone can physically read in a life time.
>
> Yes, agreed.
>
> > And the documentation doesn't help.  For example, I knew people's rules
> > about capitalizing the subject but I'd just forget.  I say that if you
> > can't be bothered to add it to checkpatch then it means you don't really
> > care that strongly.
>
> If a subsystem requires a certain spelling/capitalization in patch email
> subjects, it should be added to MAINTAINERS IMO.  E.g.,
> E:      NuBus

+1

Better make this a regex to deal with (net|net-next).

We could probably script populating MAINTAINERS with this using how it
is done manually: git log --oneline <dir>

Rob
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
