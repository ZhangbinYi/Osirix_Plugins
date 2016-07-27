#ifndef vtk_oggtheora_mangle_h
#define vtk_oggtheora_mangle_h

/*

This header file mangles all symbols exported from the oggtheora library.
It is included in all files while building the oggtheora library.  Due to
namespace pollution, no oggtheora headers should be included in .h files in
VTK.

The following command was used to obtain the symbol list:

nm libvtkoggtheora.so |grep " [TRD] "

This is the way to recreate the whole list:

nm libvtkoggtheora.so | awk --posix '/^[[:alnum:]]{8} [TRD] /{ gsub(/^_/,"",$3);  print "#define "$3" vtk_oggtheora_"$3 }{}'

REMOVE the "_init" "_fini", "_.*dyld.*", "_.*dylib.*"  and "_xC.*" entries.

*/

#define oc_bexp64 vtk_oggtheora_oc_bexp64
#define oc_blog64 vtk_oggtheora_oc_blog64
#define oc_calloc_2d vtk_oggtheora_oc_calloc_2d
#define oc_dequant_tables_init vtk_oggtheora_oc_dequant_tables_init
#define oc_enc_analyze_inter vtk_oggtheora_oc_enc_analyze_inter
#define oc_enc_analyze_intra vtk_oggtheora_oc_enc_analyze_intra
#define oc_enc_calc_lambda vtk_oggtheora_oc_enc_calc_lambda
#define oc_enc_fdct8x8 vtk_oggtheora_oc_enc_fdct8x8
#define oc_enc_fdct8x8_c vtk_oggtheora_oc_enc_fdct8x8_c
#define oc_enc_fdct8x8_mmx vtk_oggtheora_oc_enc_fdct8x8_mmx
#define oc_enc_frag_copy2 vtk_oggtheora_oc_enc_frag_copy2
#define oc_enc_frag_copy2_c vtk_oggtheora_oc_enc_frag_copy2_c
#define oc_enc_frag_copy2_mmxext vtk_oggtheora_oc_enc_frag_copy2_mmxext
#define oc_enc_frag_intra_satd vtk_oggtheora_oc_enc_frag_intra_satd
#define oc_enc_frag_intra_satd_c vtk_oggtheora_oc_enc_frag_intra_satd_c
#define oc_enc_frag_intra_satd_mmxext vtk_oggtheora_oc_enc_frag_intra_satd_mmxext
#define oc_enc_frag_recon_inter vtk_oggtheora_oc_enc_frag_recon_inter
#define oc_enc_frag_recon_intra vtk_oggtheora_oc_enc_frag_recon_intra
#define oc_enc_frag_sad vtk_oggtheora_oc_enc_frag_sad
#define oc_enc_frag_sad2_thresh vtk_oggtheora_oc_enc_frag_sad2_thresh
#define oc_enc_frag_sad2_thresh_c vtk_oggtheora_oc_enc_frag_sad2_thresh_c
#define oc_enc_frag_sad2_thresh_mmxext vtk_oggtheora_oc_enc_frag_sad2_thresh_mmxext
#define oc_enc_frag_sad_c vtk_oggtheora_oc_enc_frag_sad_c
#define oc_enc_frag_sad_mmxext vtk_oggtheora_oc_enc_frag_sad_mmxext
#define oc_enc_frag_sad_thresh vtk_oggtheora_oc_enc_frag_sad_thresh
#define oc_enc_frag_sad_thresh_c vtk_oggtheora_oc_enc_frag_sad_thresh_c
#define oc_enc_frag_sad_thresh_mmxext vtk_oggtheora_oc_enc_frag_sad_thresh_mmxext
#define oc_enc_frag_satd2_thresh vtk_oggtheora_oc_enc_frag_satd2_thresh
#define oc_enc_frag_satd2_thresh_c vtk_oggtheora_oc_enc_frag_satd2_thresh_c
#define oc_enc_frag_satd2_thresh_mmxext vtk_oggtheora_oc_enc_frag_satd2_thresh_mmxext
#define oc_enc_frag_satd_thresh vtk_oggtheora_oc_enc_frag_satd_thresh
#define oc_enc_frag_satd_thresh_c vtk_oggtheora_oc_enc_frag_satd_thresh_c
#define oc_enc_frag_satd_thresh_mmxext vtk_oggtheora_oc_enc_frag_satd_thresh_mmxext
#define oc_enc_frag_sub vtk_oggtheora_oc_enc_frag_sub
#define oc_enc_frag_sub_128 vtk_oggtheora_oc_enc_frag_sub_128
#define oc_enc_frag_sub_128_c vtk_oggtheora_oc_enc_frag_sub_128_c
#define oc_enc_frag_sub_128_mmx vtk_oggtheora_oc_enc_frag_sub_128_mmx
#define oc_enc_frag_sub_c vtk_oggtheora_oc_enc_frag_sub_c
#define oc_enc_frag_sub_mmx vtk_oggtheora_oc_enc_frag_sub_mmx
#define oc_enc_pred_dc_frag_rows vtk_oggtheora_oc_enc_pred_dc_frag_rows
#define oc_enc_rc_2pass_in vtk_oggtheora_oc_enc_rc_2pass_in
#define oc_enc_rc_2pass_out vtk_oggtheora_oc_enc_rc_2pass_out
#define oc_enc_rc_resize vtk_oggtheora_oc_enc_rc_resize
#define oc_enc_select_qi vtk_oggtheora_oc_enc_select_qi
#define oc_enc_tokenize_ac vtk_oggtheora_oc_enc_tokenize_ac
#define oc_enc_tokenize_dc_frag_list vtk_oggtheora_oc_enc_tokenize_dc_frag_list
#define oc_enc_tokenize_finish vtk_oggtheora_oc_enc_tokenize_finish
#define oc_enc_tokenize_start vtk_oggtheora_oc_enc_tokenize_start
#define oc_enc_tokenlog_rollback vtk_oggtheora_oc_enc_tokenlog_rollback
#define oc_enc_update_rc_state vtk_oggtheora_oc_enc_update_rc_state
#define oc_enc_vtable_init_c vtk_oggtheora_oc_enc_vtable_init_c
#define oc_enc_vtable_init_x86 vtk_oggtheora_oc_enc_vtable_init_x86
#define oc_enquant_qavg_init vtk_oggtheora_oc_enquant_qavg_init
#define oc_enquant_tables_init vtk_oggtheora_oc_enquant_tables_init
#define oc_frag_copy vtk_oggtheora_oc_frag_copy
#define oc_frag_copy_c vtk_oggtheora_oc_frag_copy_c
#define oc_frag_copy_mmx vtk_oggtheora_oc_frag_copy_mmx
#define oc_frag_recon_inter vtk_oggtheora_oc_frag_recon_inter
#define oc_frag_recon_inter2 vtk_oggtheora_oc_frag_recon_inter2
#define oc_frag_recon_inter2_c vtk_oggtheora_oc_frag_recon_inter2_c
#define oc_frag_recon_inter2_mmx vtk_oggtheora_oc_frag_recon_inter2_mmx
#define oc_frag_recon_inter_c vtk_oggtheora_oc_frag_recon_inter_c
#define oc_frag_recon_inter_mmx vtk_oggtheora_oc_frag_recon_inter_mmx
#define oc_frag_recon_intra vtk_oggtheora_oc_frag_recon_intra
#define oc_frag_recon_intra_c vtk_oggtheora_oc_frag_recon_intra_c
#define oc_frag_recon_intra_mmx vtk_oggtheora_oc_frag_recon_intra_mmx
#define oc_free_2d vtk_oggtheora_oc_free_2d
#define oc_hadamard_sad_thresh vtk_oggtheora_oc_hadamard_sad_thresh
#define oc_huff_codes_pack vtk_oggtheora_oc_huff_codes_pack
#define oc_huff_token_decode vtk_oggtheora_oc_huff_token_decode
#define oc_huff_trees_clear vtk_oggtheora_oc_huff_trees_clear
#define oc_huff_trees_copy vtk_oggtheora_oc_huff_trees_copy
#define oc_huff_trees_unpack vtk_oggtheora_oc_huff_trees_unpack
#define oc_idct8x8 vtk_oggtheora_oc_idct8x8
#define oc_idct8x8_c vtk_oggtheora_oc_idct8x8_c
#define oc_idct8x8_mmx vtk_oggtheora_oc_idct8x8_mmx
#define oc_iir_filter_init vtk_oggtheora_oc_iir_filter_init
#define oc_ilog vtk_oggtheora_oc_ilog
#define oc_ilog32 vtk_oggtheora_oc_ilog32
#define oc_ilog64 vtk_oggtheora_oc_ilog64
#define oc_malloc_2d vtk_oggtheora_oc_malloc_2d
#define oc_mcenc_refine1mv vtk_oggtheora_oc_mcenc_refine1mv
#define oc_mcenc_refine4mv vtk_oggtheora_oc_mcenc_refine4mv
#define oc_mcenc_search vtk_oggtheora_oc_mcenc_search
#define oc_mcenc_search_frame vtk_oggtheora_oc_mcenc_search_frame
#define oc_mode_scheme_chooser_init vtk_oggtheora_oc_mode_scheme_chooser_init
#define oc_pack_adv1 vtk_oggtheora_oc_pack_adv1
#define oc_pack_bytes_left vtk_oggtheora_oc_pack_bytes_left
#define oc_pack_look1 vtk_oggtheora_oc_pack_look1
#define oc_pack_read vtk_oggtheora_oc_pack_read
#define oc_pack_read1 vtk_oggtheora_oc_pack_read1
#define oc_pack_readinit vtk_oggtheora_oc_pack_readinit
#define oc_quant_params_clear vtk_oggtheora_oc_quant_params_clear
#define oc_quant_params_pack vtk_oggtheora_oc_quant_params_pack
#define oc_quant_params_unpack vtk_oggtheora_oc_quant_params_unpack
#define oc_rc_state_clear vtk_oggtheora_oc_rc_state_clear
#define oc_rc_state_init vtk_oggtheora_oc_rc_state_init
#define oc_restore_fpu vtk_oggtheora_oc_restore_fpu
#define oc_restore_fpu_c vtk_oggtheora_oc_restore_fpu_c
#define oc_restore_fpu_mmx vtk_oggtheora_oc_restore_fpu_mmx
#define oc_state_borders_fill vtk_oggtheora_oc_state_borders_fill
#define oc_state_borders_fill_caps vtk_oggtheora_oc_state_borders_fill_caps
#define oc_state_borders_fill_rows vtk_oggtheora_oc_state_borders_fill_rows
#define oc_state_clear vtk_oggtheora_oc_state_clear
#define oc_state_flushheader vtk_oggtheora_oc_state_flushheader
#define oc_state_frag_copy_list vtk_oggtheora_oc_state_frag_copy_list
#define oc_state_frag_copy_list_c vtk_oggtheora_oc_state_frag_copy_list_c
#define oc_state_frag_copy_list_mmx vtk_oggtheora_oc_state_frag_copy_list_mmx
#define oc_state_frag_recon vtk_oggtheora_oc_state_frag_recon
#define oc_state_frag_recon_c vtk_oggtheora_oc_state_frag_recon_c
#define oc_state_frag_recon_mmx vtk_oggtheora_oc_state_frag_recon_mmx
#define oc_state_get_mv_offsets vtk_oggtheora_oc_state_get_mv_offsets
#define oc_state_init vtk_oggtheora_oc_state_init
#define oc_state_loop_filter_frag_rows vtk_oggtheora_oc_state_loop_filter_frag_rows
#define oc_state_loop_filter_frag_rows_c vtk_oggtheora_oc_state_loop_filter_frag_rows_c
#define oc_state_loop_filter_frag_rows_mmx vtk_oggtheora_oc_state_loop_filter_frag_rows_mmx
#define oc_state_loop_filter_init vtk_oggtheora_oc_state_loop_filter_init
#define oc_state_vtable_init vtk_oggtheora_oc_state_vtable_init
#define oc_state_vtable_init_c vtk_oggtheora_oc_state_vtable_init_c
#define oc_state_vtable_init_x86 vtk_oggtheora_oc_state_vtable_init_x86
#define oc_theora_info2th_info vtk_oggtheora_oc_theora_info2th_info
#define oc_ycbcr_buffer_flip vtk_oggtheora_oc_ycbcr_buffer_flip
#define ogg_packet_clear vtk_oggtheora_ogg_packet_clear
#define ogg_page_bos vtk_oggtheora_ogg_page_bos
#define ogg_page_checksum_set vtk_oggtheora_ogg_page_checksum_set
#define ogg_page_continued vtk_oggtheora_ogg_page_continued
#define ogg_page_eos vtk_oggtheora_ogg_page_eos
#define ogg_page_granulepos vtk_oggtheora_ogg_page_granulepos
#define ogg_page_packets vtk_oggtheora_ogg_page_packets
#define ogg_page_pageno vtk_oggtheora_ogg_page_pageno
#define ogg_page_serialno vtk_oggtheora_ogg_page_serialno
#define ogg_page_version vtk_oggtheora_ogg_page_version
#define ogg_stream_check vtk_oggtheora_ogg_stream_check
#define ogg_stream_clear vtk_oggtheora_ogg_stream_clear
#define ogg_stream_destroy vtk_oggtheora_ogg_stream_destroy
#define ogg_stream_eos vtk_oggtheora_ogg_stream_eos
#define ogg_stream_flush vtk_oggtheora_ogg_stream_flush
#define ogg_stream_init vtk_oggtheora_ogg_stream_init
#define ogg_stream_iovecin vtk_oggtheora_ogg_stream_iovecin
#define ogg_stream_packetin vtk_oggtheora_ogg_stream_packetin
#define ogg_stream_packetout vtk_oggtheora_ogg_stream_packetout
#define ogg_stream_packetpeek vtk_oggtheora_ogg_stream_packetpeek
#define ogg_stream_pagein vtk_oggtheora_ogg_stream_pagein
#define ogg_stream_pageout vtk_oggtheora_ogg_stream_pageout
#define ogg_stream_reset vtk_oggtheora_ogg_stream_reset
#define ogg_stream_reset_serialno vtk_oggtheora_ogg_stream_reset_serialno
#define ogg_sync_buffer vtk_oggtheora_ogg_sync_buffer
#define ogg_sync_check vtk_oggtheora_ogg_sync_check
#define ogg_sync_clear vtk_oggtheora_ogg_sync_clear
#define ogg_sync_destroy vtk_oggtheora_ogg_sync_destroy
#define ogg_sync_init vtk_oggtheora_ogg_sync_init
#define ogg_sync_pageout vtk_oggtheora_ogg_sync_pageout
#define ogg_sync_pageseek vtk_oggtheora_ogg_sync_pageseek
#define ogg_sync_reset vtk_oggtheora_ogg_sync_reset
#define ogg_sync_wrote vtk_oggtheora_ogg_sync_wrote
#define oggpackB_adv vtk_oggtheora_oggpackB_adv
#define oggpackB_adv1 vtk_oggtheora_oggpackB_adv1
#define oggpackB_bits vtk_oggtheora_oggpackB_bits
#define oggpackB_bytes vtk_oggtheora_oggpackB_bytes
#define oggpackB_get_buffer vtk_oggtheora_oggpackB_get_buffer
#define oggpackB_look vtk_oggtheora_oggpackB_look
#define oggpackB_look1 vtk_oggtheora_oggpackB_look1
#define oggpackB_read vtk_oggtheora_oggpackB_read
#define oggpackB_read1 vtk_oggtheora_oggpackB_read1
#define oggpackB_readinit vtk_oggtheora_oggpackB_readinit
#define oggpackB_reset vtk_oggtheora_oggpackB_reset
#define oggpackB_write vtk_oggtheora_oggpackB_write
#define oggpackB_writealign vtk_oggtheora_oggpackB_writealign
#define oggpackB_writecheck vtk_oggtheora_oggpackB_writecheck
#define oggpackB_writeclear vtk_oggtheora_oggpackB_writeclear
#define oggpackB_writecopy vtk_oggtheora_oggpackB_writecopy
#define oggpackB_writeinit vtk_oggtheora_oggpackB_writeinit
#define oggpackB_writetrunc vtk_oggtheora_oggpackB_writetrunc
#define oggpack_adv vtk_oggtheora_oggpack_adv
#define oggpack_adv1 vtk_oggtheora_oggpack_adv1
#define oggpack_bits vtk_oggtheora_oggpack_bits
#define oggpack_bytes vtk_oggtheora_oggpack_bytes
#define oggpack_get_buffer vtk_oggtheora_oggpack_get_buffer
#define oggpack_look vtk_oggtheora_oggpack_look
#define oggpack_look1 vtk_oggtheora_oggpack_look1
#define oggpack_read vtk_oggtheora_oggpack_read
#define oggpack_read1 vtk_oggtheora_oggpack_read1
#define oggpack_readinit vtk_oggtheora_oggpack_readinit
#define oggpack_reset vtk_oggtheora_oggpack_reset
#define oggpack_write vtk_oggtheora_oggpack_write
#define oggpack_writealign vtk_oggtheora_oggpack_writealign
#define oggpack_writecheck vtk_oggtheora_oggpack_writecheck
#define oggpack_writeclear vtk_oggtheora_oggpack_writeclear
#define oggpack_writecopy vtk_oggtheora_oggpack_writecopy
#define oggpack_writeinit vtk_oggtheora_oggpack_writeinit
#define oggpack_writetrunc vtk_oggtheora_oggpack_writetrunc
#define th_comment_add vtk_oggtheora_th_comment_add
#define th_comment_add_tag vtk_oggtheora_th_comment_add_tag
#define th_comment_clear vtk_oggtheora_th_comment_clear
#define th_comment_init vtk_oggtheora_th_comment_init
#define th_comment_query vtk_oggtheora_th_comment_query
#define th_comment_query_count vtk_oggtheora_th_comment_query_count
#define th_decode_alloc vtk_oggtheora_th_decode_alloc
#define th_decode_ctl vtk_oggtheora_th_decode_ctl
#define th_decode_free vtk_oggtheora_th_decode_free
#define th_decode_headerin vtk_oggtheora_th_decode_headerin
#define th_decode_packetin vtk_oggtheora_th_decode_packetin
#define th_decode_ycbcr_out vtk_oggtheora_th_decode_ycbcr_out
#define th_encode_alloc vtk_oggtheora_th_encode_alloc
#define th_encode_ctl vtk_oggtheora_th_encode_ctl
#define th_encode_flushheader vtk_oggtheora_th_encode_flushheader
#define th_encode_free vtk_oggtheora_th_encode_free
#define th_encode_packetout vtk_oggtheora_th_encode_packetout
#define th_encode_ycbcr_in vtk_oggtheora_th_encode_ycbcr_in
#define th_granule_frame vtk_oggtheora_th_granule_frame
#define th_granule_time vtk_oggtheora_th_granule_time
#define th_info_clear vtk_oggtheora_th_info_clear
#define th_info_init vtk_oggtheora_th_info_init
#define th_packet_isheader vtk_oggtheora_th_packet_isheader
#define th_packet_iskeyframe vtk_oggtheora_th_packet_iskeyframe
#define th_setup_free vtk_oggtheora_th_setup_free
#define th_version_number vtk_oggtheora_th_version_number
#define th_version_string vtk_oggtheora_th_version_string
#define theora_clear vtk_oggtheora_theora_clear
#define theora_comment_add vtk_oggtheora_theora_comment_add
#define theora_comment_add_tag vtk_oggtheora_theora_comment_add_tag
#define theora_comment_clear vtk_oggtheora_theora_comment_clear
#define theora_comment_init vtk_oggtheora_theora_comment_init
#define theora_comment_query vtk_oggtheora_theora_comment_query
#define theora_comment_query_count vtk_oggtheora_theora_comment_query_count
#define theora_control vtk_oggtheora_theora_control
#define theora_decode_YUVout vtk_oggtheora_theora_decode_YUVout
#define theora_decode_header vtk_oggtheora_theora_decode_header
#define theora_decode_init vtk_oggtheora_theora_decode_init
#define theora_decode_packetin vtk_oggtheora_theora_decode_packetin
#define theora_encode_YUVin vtk_oggtheora_theora_encode_YUVin
#define theora_encode_comment vtk_oggtheora_theora_encode_comment
#define theora_encode_header vtk_oggtheora_theora_encode_header
#define theora_encode_init vtk_oggtheora_theora_encode_init
#define theora_encode_packetout vtk_oggtheora_theora_encode_packetout
#define theora_encode_tables vtk_oggtheora_theora_encode_tables
#define theora_granule_frame vtk_oggtheora_theora_granule_frame
#define theora_granule_shift vtk_oggtheora_theora_granule_shift
#define theora_granule_time vtk_oggtheora_theora_granule_time
#define theora_info_clear vtk_oggtheora_theora_info_clear
#define theora_info_init vtk_oggtheora_theora_info_init
#define theora_packet_isheader vtk_oggtheora_theora_packet_isheader
#define theora_packet_iskeyframe vtk_oggtheora_theora_packet_iskeyframe
#define theora_version_number vtk_oggtheora_theora_version_number
#define theora_version_string vtk_oggtheora_theora_version_string

#endif
