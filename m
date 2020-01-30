Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBC14E2DD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jan 2020 20:04:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C570F1007B1F4;
	Thu, 30 Jan 2020 11:07:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F06B1007B1F3
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 11:07:26 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id q84so4701830oic.4
        for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJ3nKi5Qq43imvzdAdLWCybQ+HP00VyQLY88SKjzSY0=;
        b=OdXwjuHw4jAYdsTmppA8QscMi1S3VMmfUoj89kgBNDqk8usMXtbVUJFj77sTLy9G3f
         +EiqrXw63JWiQxX4Ej7xgNAZ9UuxCET2hJ6f7sp236/rfrajFhV0mPDZcecqTCvgukx3
         m/yygTO8lIjQz/R8DVoGlHR729yX2qfJuWcZsWV3KLHlG2Avw6AEq/c7zPLJ2es5Mcg8
         k8JJtRDAqcHYWVwBgrfi/1txb1/J87CaHs2yc5etZ40AEUMP3sf+v8TGqVRPVMBxxphz
         Z4ILuQ/pSRh83M0S/l3YARLNmubMNgsIuDb819X/KbvCY7mCdk556AXQra/QIBHttCvc
         UEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJ3nKi5Qq43imvzdAdLWCybQ+HP00VyQLY88SKjzSY0=;
        b=iHjSDROrpGcM5l0Tilkkm1fgOwkVfKSqOJf0HPoj83ZKrruie4jb+23VSWkvabDCSF
         bIrYqnvyTlAxLi5cXNJ0sJZZ6aotfDZC/p78fK/Lnc7xrc9mJQVNYK/Zf8BDdCLSnezL
         NuEtr7LsvT5jr6qDfvqzo8oaYxmo8+fiOKBXUYpso2pYqVBJBWoRvQZX2jNB1qVsmr9f
         JCsnPyepky7Wwqd7NtapyyragVP/tKZmbvgwop0qiiC3TXdYDUw5yClhG0PZkSlT13GA
         VE1EERBi5dSwkh7jGg2mC2b9kx1TW8emAV5O84GI6sTcCyFIrSGGlEQVLzew5dRV7em8
         r5uQ==
X-Gm-Message-State: APjAAAWyvB4HUrwf9q4lMDi8JYlqFo+tUJAZmVO14OjKlaVqPTOONG3b
	jCW0RWCThauOJQDS3ZJy8ETupuEwV1Akw1HN1vVGIg==
X-Google-Smtp-Source: APXvYqzJnAQ6Jg6PlHcIsFgivgem0ed0ofkpH4wU5XvX6RhZ2tLc6zHEAEiHsP/0qo2mwM/vfCtBhk1cGxt4xTNUbDk=
X-Received: by 2002:a9d:1284:: with SMTP id g4mr4559035otg.207.1580411047112;
 Thu, 30 Jan 2020 11:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20200130185631.29817-1-vishal.l.verma@intel.com>
In-Reply-To: <20200130185631.29817-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Jan 2020 11:03:56 -0800
Message-ID: <CAPcyv4hLaLTdDjEhfkYHPCUyeRRSxXu=prG05WZFYtMTo=TFBQ@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/lib: make dimm_ops in private.h extern
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: AQWOQK4JV7223DRXIQCCRI5SI4FXWXN4
X-Message-ID-Hash: AQWOQK4JV7223DRXIQCCRI5SI4FXWXN4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AQWOQK4JV7223DRXIQCCRI5SI4FXWXN4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 30, 2020 at 10:56 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> A toolchain update in Fedora 32 caused new compile errors due to
> multiple definitions of dimm_ops structures. The declarations in
> 'private.h' for the various NFIT families are present so that libndctl
> can find all the per-family dimm-ops. However they need to be declared
> as extern because the actual definitions are in <family>.c

Looks good to me. Does this quiet the build spew?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
